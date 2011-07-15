From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH V2 00/16] omap_hsmmc patches
Date: Fri, 15 Jul 2011 12:32:56 +0300
Message-ID: <CANOLnOPGay+jQaeBAVD5-B3WQaWMSiPFirvhrPkeS0_ZgmX-BQ@mail.gmail.com>
References: <1304673255-31634-1-git-send-email-adrian.hunter@nokia.com>
	<CANOLnONWmYn4FpuF-UAKQR4rAA6LOgWdMfu2bMN46nna6rOxAw@mail.gmail.com>
	<m2k4bm2nwl.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <m2k4bm2nwl.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 13, 2011 at 6:36 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Wed, Jul 13 2011, Grazvydas Ignotas wrote:
>> it seems this series got lost in time, at least patches 01, 02, 03,
>> 04, 05, 06, 07, 08, 12 look like valid standalone fixes and
>> improvements to me, they don't touch other trees and still apply
>> cleanly, so would be good to have.
>
> Yeah. =C2=A0I didn't merge them because Tony still has unanswered com=
ments on
> the OMAP side of the patches, and they're submitted as a single patch=
set.
>
> I've applied {2, 3, 5, 6, 7, 8, 12} to mmc-next for 3.1 now. =C2=A01 =
doesn't
> apply because the function doesn't exist anymore. =C2=A04 doesn't app=
ly
> because iclk doesn't exist anymore.
>
> If someone wants to look at rebasing the rest of these against mmc-ne=
xt
> and resubmitting, I think that'd be useful.

Thanks! 1 and 4 seem to be unneeded any more (I was trying them on
linux-next, not noticing it was not updated for a while), and others
have comments pending, so it's all done.

>
> Thanks,
>
> - Chris.
> --
> Chris Ball =C2=A0 <cjb@laptop.org> =C2=A0 <http://printf.net/>
> One Laptop Per Child
>

--=20
Gra=C5=BEvydas
