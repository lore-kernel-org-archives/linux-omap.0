From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] ARM: OMAP: Fix tlv320aic23.c
Date: Wed, 03 May 2006 20:41:42 +0200
Message-ID: <4458F966.40504@gmail.com>
References: <4452384E.7080409@gmail.com> <20060503125606.GG30376@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060503125606.GG30376@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Tony Lindgren wrote:
> * Dirk Behme <dirk.behme@googlemail.com> [060428 08:45]:
>>Seems that the first part of
>>
>>http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commitdiff;h=51c0cddf5027bd4e5c1903845047d7d7e266c79b
>>
>>was lost somewhere??
...
> Thanks, pushed your patch.
> 
> I think the earlier patch chunk has gotten auto-hosed by git merge in
> Juha's recent merge:
> 
> http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commit;h=330c1eb9a689973326cdece277d0b4b409833bb9
> 
> Mika & Dirk, can you guys check if some of the other audio files got
> hosed or some old audio files got added back?

Mmmh, seems that something is going on here I don't
understand completely ;(

While building modules with most recent git I get two
warnings (or better errors, modules are not build):

WARNING: "tlv320aic23_write_value"
[sound/arm/omap/snd-omap-alsa-aic23.ko] undefined!
WARNING: "usb_disconnect" [drivers/usb/host/ohci-hcd.ko]
undefined!

Not sure if USB is OMAP related, but aic is. Looking at

http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=blobdiff;h=fac8d6b7518032f54869cc309328e812e16892be;hp=7fdd1d3608b2c41141901acff4b79df27b0f53df;hb=51c0cddf5027bd4e5c1903845047d7d7e266c79b;f=drivers/i2c/chips/tlv320aic23.c

shows that from function names and variables 'tlv320' was
removed. However, commitdiff only shows the small (correct)
patch.

Patch in seperate mail.

Any ideas about USB? Seems that it comes from
drivers/usb/host/ohci-omap.c

Regards

Dirk
