From: Ashwin Bihari <abihari@gmail.com>
Subject: Re: [PATCH v4 0/4] LogicPD minimal board support for LV_SOM and Torpedo
Date: Mon, 11 Oct 2010 14:40:51 -0400
Message-ID: <AANLkTikK6QAwj_T67NQAhVDT2T+D3tbBbOt9vDyme6N=@mail.gmail.com>
References: <1285603550-6382-1-git-send-email-tim.nordell@logicpd.com>
	<20100928171908.GE3117@atomide.com>
	<201010090155.25932.linz@li-pro.net>
	<4CAFB747.5020606@logicpd.com>
	<20101011173023.GB25462@atomide.com>
	<4CB34D55.6060007@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4CB34D55.6060007@logicpd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Nordell <tim.nordell@logicpd.com>
Cc: Tony Lindgren <tony@atomide.com>, Stephan Linz <linz@li-pro.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 11, 2010 at 1:45 PM, Tim Nordell <tim.nordell@logicpd.com> =
wrote:
> =A0On 10/11/10 12:30, Tony Lindgren wrote:
>> Uhh, so whose patches are these originally?
>>
>> We have them now queued with Tim Nordell as the author. Please let m=
e know
>> ASAP if you want me to change that.
>>
>> Regards,
>>
>> Tony
>
> The history for those patches, for me, originated with Jacob Tanenbau=
m's
> patchset. =A0I was taking over for him as he was going back to school=
=2E =A0I
> did some misc. changes for further submission, but I was not the
> original author. =A0I don't know Stephan's involvement - however, in =
the
> source files he's attributed credit in the header, as well as one of =
my
> coworkers so presumably there was some involvement on both ends. =A0I
> recognize some of the code as coming from our kernel release, so like=
ly
> it was a hybrid originally between Stephan, Peter, and Jacob.
>
> That's about the extent that I know.
>
> - Tim

Tony,

LogicPD engineers did the initial porting and then Stephan Linz
re-started the work on the, then recent, 2.6.32 Kernel using our BSP
as a starting point. He was kind enough to send those LogicPD and we
began putting it together against the latest Linux Kernel for
inclusion and that was done by Jacob over the summer and finished off
by Tim.

Stephan Linz is credited in the patch and Peter Barada (another
LogicPD employee) is listed as the maintainer though his part (along
with me) in getting these specific patches out have been more behind
the scenes. So having the names listed as they are now is OK.

In the upcoming months we will be pushing out additional support for
the LogicPD's boards and it will most likely come up a variety of
LogicPD engineers depending on our workload..

Thanks
-- Ashwin
