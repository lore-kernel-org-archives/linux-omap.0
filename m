From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH] ARM: dts: am57xx-beagle-x15: fix HDMI LS_OE GPIO
Date: Tue, 14 Nov 2017 10:07:31 -0600
Message-ID: <CAOCHtYh8BfdGg5BGvM9=BUm0oVonXWTtCe7degdRfdcMGn4AYg@mail.gmail.com>
References: <1472737901-26494-1-git-send-email-tomi.valkeinen@ti.com>
 <b8647621-197c-97d5-8291-26c079e5eae8@ti.com>
 <CAOCHtYhF2KfeK3ccEzZcePbU5H1kwi1tKThZN3NRwXgPsW_bSA@mail.gmail.com>
 <c69aadbf-90e4-7aaf-2b90-4d5b543c252a@ti.com>
 <20160901145757.4oksrst3wpjpsscf@atomide.com>
 <de3bf6ab-a07a-b82d-1e45-5f96a6e1039e@ti.com>
 <CAN20qYqq9DGSgcTaivZHrD+RMY1WLPLNGv2K7xp0pvArJWuGEg@mail.gmail.com>
 <09c701bd-066a-7af7-14c2-4f9cb2481371@ti.com>
 <CAN20qYrw=sW+bo-0pHoPThABzrw8r0ujrdHhZcytxVHbCnromw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAN20qYrw=sW+bo-0pHoPThABzrw8r0ujrdHhZcytxVHbCnromw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bill Traynor <btraynor@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, "beagleboard-x15@googlegroups.com" <beagleboard-x15@googlegroups.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 14, 2017 at 8:14 AM, Bill Traynor <btraynor@gmail.com> wrote:
> On Tue, Nov 14, 2017 at 2:33 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> On 14/11/17 02:27, Bill Traynor wrote:
>>
>>> I'm getting this error again with the latest X15 image on my A2
>>> version board.  I don't see this patch in the mainline kernel.  Did it
>>> never get applied?
>>
>> With am57xx-beagle-x15.dts? That seems be the A2 version.
>
> Yes.
> I see the following in the boot message
>
> loading /boot/dtbs/4.9.35-ti-r44/am57xx-beagle-x15.dtb ...
>
> I can get around this by inserting/uninserting an sdcard once the
> kernel starts booting.
>
> This is with the Debian 9.0 2017-07-02 4GB SD LXQT image.

Weird, ldo1 is set to always on:

https://github.com/RobertCNelson/linux-stable-rcn-ee/blob/4.9.35-ti-r44/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi#L276-L283

Something else is going on..

Regards,

-- 
Robert Nelson
https://rcn-ee.com/
