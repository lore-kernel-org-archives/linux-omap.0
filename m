From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] omap: twl-common: Fix musb-hdrc device name.
Date: Mon, 16 Dec 2013 14:22:06 +0530
Message-ID: <52AEBF36.9010400@ti.com>
References: <1386059589-4030-1-git-send-email-marek.belisko@open-nandra.com>
 <529D9D43.6040101@ti.com>
 <CAAfyv37Vie1vZK2XQ1cfVq6eVnSuaBLfykk6pU8fwEyqvPF4BA@mail.gmail.com>
 <CAAfyv35gVVNydrk8vifSyidpFjEXjGiT4-i2dgN5Un2=FuHaqQ@mail.gmail.com>
 <20131205184323.GF26766@atomide.com>
 <CAAfyv37e9+OLH-KegPCEhc0sbBS7UVnaSGU0mBw2AxAN9D7Akw@mail.gmail.com>
 <20131209175006.GD12527@atomide.com>
 <CAAfyv36P7DDcdaLWtXnZXPfQWPL20shE3kOHWtD0mSmH7aixdg@mail.gmail.com>
 <52AAF5E6.1050900@ti.com> <20131213173636.GG28184@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131213173636.GG28184@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, "balbi@ti.com" <balbi@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Belisko Marek <marek.belisko@gmail.com>, LKML <linux-kernel@vger.kernel.org>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Friday 13 December 2013 11:06 PM, Tony Lindgren wrote:
> * Kishon Vijay Abraham I <kishon@ti.com> [131213 03:57]:
>> On Friday 13 December 2013 04:57 PM, Belisko Marek wrote:
>>> Kishon can you please comment on that? Would be possible to get your
>>> patch to 3.13 (I seen some comments from Felipe).
>>
>> I'm not sure as my patch modifies all the board files. There was initially some
>> confusion w.r.t when the board files will be dropped. But since board files
>> will still be there in 3.13, I'd recommend my patch  [1] to be taken. Anyways
>> if you have tested my patch (series), pls give your Tested-by.
>>
>> Tony, summary of the issue..
>> After the platform devices are created using PLATFORM_DEVID_AUTO, the
>> device names given in usb_bind_phy (in board file) does not match with
>> the actual device name causing the USB PHY library not to return the
>> PHY reference when the MUSB controller request for the PHY in the non-dt boot
>> case. So removed creating platform devices using PLATFORM_DEVID_AUTO in
>> omap2430.c. So had to make the corresponding changes in board files.
> 
> OK. Can you please repost with a proper commit id for what caused the
> regression and summararize why it should be fixed this way. Something like:
> 
> Commit abcd1234 (usb: blah foo bar) caused blah blah blah. Fix the issue
> with blah blah blah. Note that the board-*.c files will be removed soon,
> but for v3.13 we still support both legacy booting and device tree based
> booting and need to fix it.

huh.. I think we can have a much simpler fix. All this binding in board file
was introduced to support platforms that has multiple PHYs of the same type.
But musb/omap2430.c serves platforms that has only one PHY of a particular
type. We can just go back to usb_get_phy(enum usb_phy_type type) instead of
'usb_get_phy_dev' in omap2430.c. Felipe, what do you think?

Cheers
Kishon

> 
> Regards,
> 
> Tony
>  
>> [1] -> http://lists.scusting.com/index.php?t=msg&th=375579&start=0&S=Google
