From: Stefan Roese <ml@roese.nl>
Subject: Re: Kernel panics on OSK5912
Date: Fri, 26 May 2006 09:08:02 +0200
Message-ID: <200605260908.03332.ml@roese.nl>
References: <20060526063240.84781.qmail@web52306.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20060526063240.84781.qmail@web52306.mail.yahoo.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
Cc: Eduardo Gallofin <egallofin@yahoo.com>
List-Id: linux-omap@vger.kernel.org

Hi Eduardo,

On Friday 26 May 2006 08:32, Eduardo Gallofin wrote:
>   I got a problem with the 2.6.16 kernel running on my
> OSK. It panics after (or when) running init. I'm not
> sure what the problem is and MontaVista's kernel works
> fine with my rootfs.
>
>   The same kernel and rootfs, however, works with our
> other OSK5912 board....

We experienced similar problems on our OSK5912. The problems are SDRAM setup 
related and can be solved by updating to the latest U-Boot version. Please 
download and install the top-of-git version and give it a try.

Best regards,
Stefan
