From: Komal Shah <komal_shah802003@yahoo.com>
Subject: RE: [PATCH] Convert touchscreen to input_allocate_device
Date: Tue, 17 Jan 2006 07:12:57 -0800 (PST)
Message-ID: <20060117151257.67182.qmail@web32915.mail.mud.yahoo.com>
References: <890E52023811004CB455C1B7C433BA101A8B28@dino.eu.tieto.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <890E52023811004CB455C1B7C433BA101A8B28@dino.eu.tieto.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Mikko.Soikkala@Tietoenator.com, dirk.behme@de.bosch.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Mikko.Soikkala@Tietoenator.com wrote:

> 
> I'm still learning how to create and submit patches, but hopefully
> this
> does the trick.
> 
> Mikko
> 
>  	ts_omap.inputdevice = input_allocate_device();
> +	if (!ts_omap.inputdevice)
> +		return -ENOMEM;
> +

Not good enough. 

1. Need to free the irq, you just got before this code.
2. Need to call ts_omap.dev->remove() to match _probe() for the
corresponding platform before you return -ENOMEM.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
