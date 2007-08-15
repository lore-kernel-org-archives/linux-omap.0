From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] MUSB_HDRC: Convert printk() to dev_* macros
Date: Wed, 15 Aug 2007 10:45:14 -0700
Message-ID: <200708151045.15008.david-b@pacbell.net>
References: <200708150944.28365.david-b@pacbell.net>
	<11871986031263-git-send-email-felipe.lima@indt.org.br>
	<11871986091227-git-send-email-felipe.lima@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11871986091227-git-send-email-felipe.lima@indt.org.br>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Felipe Balbi <felipe.lima@indt.org.br>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Wednesday 15 August 2007, Felipe Balbi wrote:
> @@ -1128,8 +1127,7 @@ static int __init ep_config_from_table(struct musb *musb)
>  		break;
>  	}
>  
> -	printk(KERN_DEBUG "%s: setup fifo_mode %d\n",
> -			musb_driver_name, fifo_mode);
> +	dev_dbg(musb->controller, "setup fifo_mode %d\n", fifo_mode);

That change is not equivalent ... in one case the FIFO mode
always gets logged (at low priority), but you've changed it
so that it normally doesn't get logged.  Fifo mode can be
quite significant when troubleshooting in the field, since
it affects what drivers can do with the various endpoints
(and hence what driver can even run).


>  	offset = fifo_setup(musb, hw_ep, &ep0_cfg, 0);
> @@ -1157,14 +1155,13 @@ static int __init ep_config_from_table(struct musb *musb)
>  		musb->nr_endpoints = max(epn, musb->nr_endpoints);
>  	}
>  
> -	printk(KERN_DEBUG "%s: %d/%d max ep, %d/%d memory\n",
> -			musb_driver_name,
> +	dev_dbg(musb->controller, "%d/%d max ep, %d/%d memory\n",

Ditto.  This stuff can matter to someone trying to figure out
why after "modprobe ... fifo_mode=X" their system was misbehaving.


>  			n + 1, MUSB_C_NUM_EPS * 2 - 1,
>  			offset, DYN_FIFO_SIZE);
>  
> @@ -1293,8 +1290,7 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
>  		strcat(aInfo, ", SoftConn");
>  	}
>  
> -	printk(KERN_DEBUG "%s: ConfigData=0x%02x (%s)\n",
> -			musb_driver_name, reg, aInfo);
> +	dev_dbg(musb->controller, "ConfigData=0x%02x (%s)\n", reg, aInfo);

Ditto, though in this case config data isn't very useful
except to someone doing low level debugging, so that's OK.


>  
>  #ifdef MUSB_AHB_ID
>  	dwData = musb_readl(mbase, 0x404);
> @@ -1302,9 +1298,9 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
>  		(dwData >> 16) & 0xff, (dwData >> 24) & 0xff);
>  	/* FIXME ID2 and ID3 are unused */
>  	dwData = musb_readl(mbase, 0x408);
> -	printk("ID2=%lx\n", (long unsigned)dwData);
> +	dev_info(musb->controller, "ID2=%lx\n", (long unsigned)dwData);
>  	dwData = musb_readl(mbase, 0x40c);
> -	printk("ID3=%lx\n", (long unsigned)dwData);
> +	dev_info(musb->controller, "ID3=%lx\n", (long unsigned)dwData);

These would be better as dev_dbg().  Does this show up
on omapX430 chips, or is all that code still "dead"?



> @@ -1331,8 +1325,8 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
>  	wRelMinor = wRelease & 0x3ff;
>  	snprintf(aRevision, 32, "%d.%d%s", wRelMajor,
>  		wRelMinor, (wRelease & 0x8000) ? "RC" : "");
> -	printk(KERN_DEBUG "%s: %sHDRC RTL version %s %s\n",
> -			musb_driver_name, type, aRevision, aDate);
> +	dev_dbg(musb->controller, "%sHDRC RTL version %s %s\n",
> +			type, aRevision, aDate);

Same comment about loss of functionality ... silicon version data
can be very significant for runtime troubleshooting, don't remove
this data from binaries that will be "in the field".


>  	/* configure ep0 */
>  	musb->endpoints[0].max_packet_sz_tx = MGC_END0_FIFOSIZE;
> @@ -1386,19 +1380,18 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
>  #endif
>  
>  		if (hw_ep->max_packet_sz_tx) {
> -			printk(KERN_DEBUG
> -				"%s: hw_ep %d%s, %smax %d\n",
> -				musb_driver_name, i,
> -				hw_ep->is_shared_fifo ? "shared" : "tx",
> +			dev_dbg(musb->controller,
> +				"hw_ep %d%s, %smax %d\n",
> +				i, hw_ep->is_shared_fifo
> +					? "shared" : "tx",

Ditto.  Without access to source, this is usually the *ONLY* information
available to userspace about how the endpoints were set up, and that can
be important for in-the-field debugging.


>  				hw_ep->tx_double_buffered
>  					? "doublebuffer, " : "",
>  				hw_ep->max_packet_sz_tx);
>  		}
>  		if (hw_ep->max_packet_sz_rx && !hw_ep->is_shared_fifo) {
> -			printk(KERN_DEBUG
> -				"%s: hw_ep %d%s, %smax %d\n",
> -				musb_driver_name, i,
> -				"rx",
> +			dev_dbg(musb->controller,
> +				"hw_ep %d%s, %smax %d\n",
> +				i, "rx",

... and again ...


> @@ -1713,7 +1706,7 @@ musb_srp_store(struct device *dev, struct device_attribute *attr,
>  
>  	if (sscanf(buf, "%hu", &srp) != 1
>  			|| (srp != 1)) {
> -		printk (KERN_ERR "SRP: Value must be 1\n");
> +		dev_err(dev, "SRP: Value must be 1\n");

Doesn't this error test look as bogus to you as it does to me?
If there's only one thing a write could mean, don't bother even
looking at the value.  And the test below that is clearly made
irrelevant by this test here ...
