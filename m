From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Error handling in drivers/pci/host/pci-dra7xx.c
Date: Wed, 13 Jul 2016 06:59:32 +0200
Message-ID: <edb7b73b-3880-23a5-99ff-2b5b30f45ace@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

(resent because of broken cc)


Hi,

in file 'drivers/pci/host/pci-dra7xx.c', error handling in 
'dra7xx_pcie_init_irq_domain()' seams to be broken.

The pattern used is:

    if (!var) {
       ...
       dev_err(...);
       return PTR_ERR(var);
    }

so we always return '0', which means success.

Returning PTR_ERR(-EINVAL) or PTR_ERR(-ENODEV) could be, IMHO, better.

Best regards,

CJ
