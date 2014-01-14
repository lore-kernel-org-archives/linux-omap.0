From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: sleep: byteswap data for big-endian
Date: Tue, 14 Jan 2014 18:44:09 -0500
Message-ID: <52D5CBC9.5020201@ti.com>
References: <1389625399-24087-1-git-send-email-taras.kondratiuk@linaro.org>
 <52D404DE.2020806@ti.com>
 <CAArO44samX_uMeC93w4DBbC+yskEmrvVt_i-5VV_seatM56ypw@mail.gmail.com>
 <52D55CE5.1060902@ti.com>
 <CAA3XUr2cnF_rxMYvZfjBx22Sa8YE45o_qUU8GNoerQwhWqxhNQ@mail.gmail.com>
 <CAGo_u6oKpRFnPAWaqr9NTNAJB+m56jiDgBUgvsiZpaQ-3SF2kw@mail.gmail.com>
 <CAA3XUr1_cNuPmMU6Fs6c7Si2So0VFGcLyGJe+tS_R47BVKRXnw@mail.gmail.com>
 <CAGo_u6p7ErrKOMy4Ljg3nehVpd=DOg3XDn6gZ1nrFE_OuOjsWg@mail.gmail.com>
 <52D5A60C.7080800@ti.com>
 <CAGo_u6oGDK5s0SeE6Z7UFM6eYdgoy-E+Tj67+pBWP-wQ3r9=QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAGo_u6oGDK5s0SeE6Z7UFM6eYdgoy-E+Tj67+pBWP-wQ3r9=QA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: Linaro Kernel <linaro-kernel@lists.linaro.org>, Russell King <linux@arm.linux.org.uk>, Victor Kamensky <victor.kamensky@linaro.org>, Tony Lindgren <tony@atomide.com>, Taras Kondratiuk <taras.kondratiuk@linaro.org>, Patch Tracking <patches@linaro.org>, open list <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>, Linaro Networking <linaro-networking@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tuesday 14 January 2014 04:13 PM, Nishanth Menon wrote:
> On Tue, Jan 14, 2014 at 3:03 PM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
>>
>>> ok.. some sort of Linaro thing about which I have no background about
>>> - but dont really care in this context.
>>>
>> Nothing related Linaro. Its just that platforms are supporting ARM BE
>> mode and Linaro folks had working patches for Panda. So I suggested
>> to get them on the lists.
> 
> I tend to think -> is this with OFF mode and CPUidle completely
> working? All context save and restore works with this? on HS and GP
> devices with BE mode builds? works on SDP4430,60 variations,
> considered reuse with AM43xx which could use parts of that logic?
> 
> I mean to indicate that terms like "works on panda" tends always to be relative.
>
Fair enough.
 
> It is nice to see it as a proof of concept, but I'd hate to see some
> dead code lying around in kernel and folks blindly following suit and
> introducing macros for new assembly for a feature that in practice
> just one group of folks care about and creates additional burden for
> rest of folks trying to keep that functionality going as we jump from
> one "device tree" style churn to another "framework"? Not to mean that
> good features should be kept away.. but personally, I could not find
> convincing arguments in this case..
> 
I haven't looked at patch myself but as you pointed out if it adds
dead code and makes the code un-readable then probably that something
we shouldn't merge.

Regards,
Santosh
