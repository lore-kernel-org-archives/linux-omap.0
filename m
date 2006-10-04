From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Recent git kernels and OSK
Date: Wed, 04 Oct 2006 11:03:54 +0200
Message-ID: <452378FA.9050604@gmail.com>
References: <4521941B.2020102@balister.org> <45226BC5.9050201@gmail.com>
	<452280A5.5080805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <452280A5.5080805@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Dirk Behme wrote:
>> Just checked it. Seems that recent git on OSK is really broken. 
>> Enabling lowlevel debug last thing I get is kernel command line output 
>> [3]. On my last working kernel next output would be clock stuff [2]
>  
>> Any ideas?
> 
> Seems to me that it hangs in arch/arm/mach-omap1/clock.c in 
> omap1_clk_init in

As already mentioned in my last mail, this seems to be 
related to broken low level debug.

Doing some more debugging (with low level debug disabled 
now) shows that at least until "ARM: OMAP: DSPGW: mailbox 
log cleanup" [1] everything is okay. Then, with all changes 
including "ARM: OMAP: DSPGW: Peripheral (kfunc) control" [2] 
it seems to be broken.

So maybe DSPGW changes cause the trouble on OSK. Can anybody 
with DSPGW knowledge re-check this on OSK?

Many thanks,

Dirk

[1]
http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commit;h=0992816784c16d294b884c15fde6fe469a18a01f

[2]
http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commit;h=0a1de60c0d0f0c9f634a8673a1918f716c2cdcad
