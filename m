From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi/omap: cleanup probe/remove routines
Date: Wed, 09 May 2012 18:37:20 -0600
Message-ID: <20120510003720.2F90C3E08F4@localhost>
References: <1336567438-6715-1-git-send-email-hannuxx@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1336567438-6715-1-git-send-email-hannuxx-X3B1VOXEql0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Hannu Heikkinen <hannuxx-X3B1VOXEql0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed,  9 May 2012 15:43:58 +0300, Hannu Heikkinen <hannuxx-X3B1VOXEql0@public.gmane.org> wrote:
> Cleanup probe and remove routines, use devm_* functions for
> managing resources.
> 
> Also, in under free_master label, change use of kfree() into
> spi_master_put().

Patch does not apply to my current spi/next branch[1].

[1]git://git.secretlab.ca/git/linux-2.6 spi/next

While I'm thinking about it; Kevin, how do you want me handling OMAP
spi patches.  Do you want to pick them up, test them and send me a git
branch to pull like with gpio?  Or can I just pick them up?

g.

> 
> CC: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
> CC: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
> Signed-off-by: Hannu Heikkinen <hannuxx-X3B1VOXEql0@public.gmane.org>
> ---
>  drivers/spi/spi-omap2-mcspi.c |   27 ++++++---------------------
>  1 file changed, 6 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index bb9274c..392efce 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -1166,17 +1166,12 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
>  	r->start += regs_offset;
>  	r->end += regs_offset;
>  	mcspi->phys = r->start;
> -	if (!request_mem_region(r->start, resource_size(r),
> -				dev_name(&pdev->dev))) {
> -		status = -EBUSY;
> -		goto free_master;
> -	}
>  
> -	mcspi->base = ioremap(r->start, resource_size(r));
> +	mcspi->base = devm_request_and_ioremap(&pdev->dev, r);
>  	if (!mcspi->base) {
> -		dev_dbg(&pdev->dev, "can't ioremap MCSPI\n");
> -		status = -ENOMEM;
> -		goto release_region;
> +		dev_dbg(&pdev->dev, "can't request mem and ioremap MCSPI\n");
> +		status =  -ENOMEM;
> +		goto free_master;
>  	}
>  
>  	mcspi->dev = &pdev->dev;
> @@ -1191,7 +1186,7 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
>  			GFP_KERNEL);
>  
>  	if (mcspi->dma_channels == NULL)
> -		goto unmap_io;
> +		goto free_master;
>  
>  	for (i = 0; i < master->num_chipselect; i++) {
>  		char dma_ch_name[14];
> @@ -1241,12 +1236,8 @@ disable_pm:
>  	pm_runtime_disable(&pdev->dev);
>  dma_chnl_free:
>  	kfree(mcspi->dma_channels);
> -unmap_io:
> -	iounmap(mcspi->base);
> -release_region:
> -	release_mem_region(r->start, resource_size(r));
>  free_master:
> -	kfree(master);
> +	spi_master_put(master);
>  	platform_set_drvdata(pdev, NULL);
>  	return status;
>  }
> @@ -1256,8 +1247,6 @@ static int __exit omap2_mcspi_remove(struct platform_device *pdev)
>  	struct spi_master	*master;
>  	struct omap2_mcspi	*mcspi;
>  	struct omap2_mcspi_dma	*dma_channels;
> -	struct resource		*r;
> -	void __iomem *base;
>  
>  	master = dev_get_drvdata(&pdev->dev);
>  	mcspi = spi_master_get_devdata(master);
> @@ -1265,12 +1254,8 @@ static int __exit omap2_mcspi_remove(struct platform_device *pdev)
>  
>  	omap2_mcspi_disable_clocks(mcspi);
>  	pm_runtime_disable(&pdev->dev);
> -	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	release_mem_region(r->start, resource_size(r));
>  
> -	base = mcspi->base;
>  	spi_unregister_master(master);
> -	iounmap(base);
>  	kfree(dma_channels);
>  	destroy_workqueue(mcspi->wq);
>  	platform_set_drvdata(pdev, NULL);
> -- 
> 1.7.10
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
