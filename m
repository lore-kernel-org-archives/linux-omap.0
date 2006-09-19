From: Stefano Babic <stefano.babic@babic.homelinux.org>
Subject: Re: problem about  io.h file!!!!
Date: Tue, 19 Sep 2006 11:09:20 +0200
Message-ID: <200609191109.20729.stefano.babic@babic.homelinux.org>
References: <20060906142120.98809.qmail@web30614.mail.mud.yahoo.com>
	<002901c6db97$5415d760$4e0aa8c0@wbb>
	<001f01c6dbc9$399344e0$4e0aa8c0@wbb>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <001f01c6dbc9$399344e0$4e0aa8c0@wbb>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Tuesday 19 September 2006 10:52, w.b.b wrote:
>  that:
>   #include<asm/arch/gpio.h>
> main()
> {
> omap_request_gpio(3);
> omap_set_gpio_direction(3,1);
> }
You cannot call these functions in user space. They are available only in 
kernel. Write a simple char driver to use them.

stefano

-- 
stefano <stefano.babic@babic.homelinux.org>
GPG Key: 0x55814DDE 
Fingerprint 4E85 2A66 4CBA 497A 2A7B D3BF 5973 F216 5581 4DDE
