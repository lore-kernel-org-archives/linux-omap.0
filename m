From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH 1/5 v13] arm: omap: usb: ehci and ohci hwmod structures
 for omap4
Date: Fri, 7 Oct 2011 19:57:18 +0530
Message-ID: <CAP05o4+KMrFc6QHVdzuw6qR6BzkHxsSDssA=B0A_TS8fWp-mbg@mail.gmail.com>
References: <1317901099-2519-1-git-send-email-keshava_mgowda@ti.com>
	<alpine.DEB.2.00.1110070305040.4611@utopia.booyaka.com>
	<CAP05o4J39MotDTOv-O2ahvWfxL-7jC-L3FGsNXbmDy8HNg=W3g@mail.gmail.com>
	<alpine.DEB.2.00.1110070330220.4611@utopia.booyaka.com>
	<CAP05o4LMjfwGMtYH02XTv9UqO7nEPSu2fijnOPceVjK-dyUgwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAP05o4LMjfwGMtYH02XTv9UqO7nEPSu2fijnOPceVjK-dyUgwg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, sameo@linux.intel.com, balbi@ti.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, gadiyar@ti.com, parthab@india.ti.com, tony@atomide.com, johnstul@us.ibm.com, vishwanath.bs@ti.com
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 7, 2011 at 4:13 PM, Munegowda, Keshava
<keshava_mgowda@ti.com> wrote:
> On Fri, Oct 7, 2011 at 3:05 PM, Paul Walmsley <paul@pwsan.com> wrote:
>> On Fri, 7 Oct 2011, Munegowda, Keshava wrote:
>>
>>> Thanks Paul;
>>> yes, I can your changes in the patches.
>>> so, you don't need v14 from me right? please confirm.
>>> I am preparing/validating next version patches with =A0OCPIF_SWSUP_=
IDLE removed.
>>> Thanks for guiding me and helping on the finalizing the hwmod confi=
gurations.
>>
>> The first two patches of the series -- the OMAP3/4 hwmod data patche=
s --
>> have been queued for 3.2 in the 'hwmod_devel_3.2' branch of
>> git://git.pwsan.com/linux-2.6
>
> Ok, then I will host a tree for remaining three patches and another
> last patch for MFD tree.

Hi Felipe and Sameo

The patches are available in the branch kmg-usbhs-pm of
git repository: git@gitorious.org:~kmg/mirrors/kmg-usbhs-pm.git

if you have review comment on v13 of these series; please let me know.
so I that I will make the changes in time.

 regards
 keshava


>
>> So we don't need new versions of those two.
>>
>> But we need to figure out what to do about the remaining three
>> patches. =A0I still think that the TLL and UHH hwmods should have
>> separate drivers. =A0Looks like Felipe has a question pending about =
that
>> but it's unlikely that I'll have time to dig into it for at least a
>> few days. =A0So I'd encourage you to try splitting those UHH and TLL
>> drivers in the meantime.
>>
>>
>> - Paul
>>
>
