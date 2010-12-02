From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: Re: [PATCHv5 0/4] omap: iovmm - fixes for iovmm module
Date: Wed, 1 Dec 2010 19:36:34 -0600
Message-ID: <AANLkTimQcXrgxGjZonSUSkXqoHfAVVhXuHnGKBkMKc9X@mail.gmail.com>
References: <1288033806-1496-1-git-send-email-x0095840@ti.com>
	<20101129.104729.97149649.Hiroshi.DOYU@nokia.com>
	<1291231567-notmuch-felipe.contreras@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1291231567-notmuch-felipe.contreras@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@nokia.com>
Cc: Hiroshi.DOYU@nokia.com, x0095840@ti.com, h-kanigeri2@ti.com, tony@atomide.com, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 1, 2010 at 1:27 PM, Felipe Contreras
<felipe.contreras@nokia.com> wrote:
> Hiroshi.DOYU@nokia.com wrote:
>> From: ext Fernando Guzman Lugo <x0095840@ti.com>
>> Subject: [PATCHv5 0/4] omap: iovmm - fixes for iovmm module
>> Date: Mon, 25 Oct 2010 21:10:02 +0200
>>
>> > Version 5:
>> > * Changes in "iommu: create new api to set valid da range"
>> > =A0 - Change range variables to platform data structure.
>>
>> Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
>
> Does that means you are going to send a pull request with these for .=
38?
>
> Fernando, is there a branch where you have all the changes needed in
> tidspbridge?

No, I dont have that branch.

>
> I guess the only patch missing would be the one for linux-arm.

Yes, after merging them, the only missing is the SG chain patch.

Regards,
=46ernando.

>
> Cheers.
>
> --
> Felipe Contreras
>
