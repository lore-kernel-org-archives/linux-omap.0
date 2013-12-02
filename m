From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: mmc: omap: Fix DMA configuration to not rely on device id
Date: Mon, 2 Dec 2013 11:06:09 +0300
Message-ID: <20131202080608.GA3852@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:27955 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190Ab3LBIGc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Dec 2013 03:06:32 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

Hello Tony Lindgren,

This is a semi-automatic email about new static checker warnings.

The patch 31ee9181eb92: "mmc: omap: Fix DMA configuration to not rely 
on device id" from Nov 26, 2013, leads to the following Smatch 
complaint:

drivers/mmc/host/omap.c:1468 mmc_omap_probe()
	 error: we previously assumed 'res' could be null (see line 1410)

drivers/mmc/host/omap.c
  1409		res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
  1410		if (res)
                    ^^^
Patch introduces a check.

  1411			sig = res->start;
  1412		host->dma_rx = dma_request_slave_channel_compat(mask,
  1413					omap_dma_filter_fn, &sig, &pdev->dev, "rx");
  1414		if (!host->dma_rx)
  1415			dev_warn(host->dev, "unable to obtain RX DMA engine channel %u\n",
  1416				sig);
  1417	
  1418		ret = request_irq(host->irq, mmc_omap_irq, 0, DRIVER_NAME, host);
  1419		if (ret)
  1420			goto err_free_dma;
  1421	
  1422		if (pdata->init != NULL) {
  1423			ret = pdata->init(&pdev->dev);
  1424			if (ret < 0)
  1425				goto err_free_irq;
  1426		}
  1427	
  1428		host->nr_slots = pdata->nr_slots;
  1429		host->reg_shift = (mmc_omap7xx() ? 1 : 2);
  1430	
  1431		host->mmc_omap_wq = alloc_workqueue("mmc_omap", 0, 0);
  1432		if (!host->mmc_omap_wq)
  1433			goto err_plat_cleanup;
  1434	
  1435		for (i = 0; i < pdata->nr_slots; i++) {
  1436			ret = mmc_omap_new_slot(host, i);
  1437			if (ret < 0) {
  1438				while (--i >= 0)
  1439					mmc_omap_remove_slot(host->slots[i]);
  1440	
  1441				goto err_destroy_wq;
  1442			}
  1443		}
  1444	
  1445		return 0;
  1446	
  1447	err_destroy_wq:
  1448		destroy_workqueue(host->mmc_omap_wq);
  1449	err_plat_cleanup:
  1450		if (pdata->cleanup)
  1451			pdata->cleanup(&pdev->dev);
  1452	err_free_irq:
  1453		free_irq(host->irq, host);
  1454	err_free_dma:
  1455		if (host->dma_tx)
  1456			dma_release_channel(host->dma_tx);
  1457		if (host->dma_rx)
  1458			dma_release_channel(host->dma_rx);
  1459		clk_put(host->fclk);
  1460	err_free_iclk:
  1461		clk_disable(host->iclk);
  1462		clk_put(host->iclk);
  1463	err_free_mmc_host:
  1464		iounmap(host->virt_base);
  1465	err_ioremap:
  1466		kfree(host);
  1467	err_free_mem_region:
  1468		release_mem_region(res->start, resource_size(res));
                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Existing unchecked dereferences.

  1469		return ret;
  1470	}

regards,
dan carpenter
