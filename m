From: Mike Rapoport <mike.rapoport@gmail.com>
Subject: Re: [PATCH] Input: ads7846: add regulator support
Date: Fri, 5 Feb 2010 22:45:09 +0200
Message-ID: <f870da181002051245t2f37065duae595fee391e7fd9@mail.gmail.com>
References: <1265290758-2035-1-git-send-email-notasas@gmail.com>
	 <20100204142439.GA1139@sirena.org.uk>
	 <6ed0b2681002040652r722e3df2s3f032a9fe0d0c0fe@mail.gmail.com>
	 <20100204162155.GB29982@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20100204162155.GB29982@rakim.wolfsonmicro.main>
Sender: linux-input-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-omap@vger.kernel.org, lrg@slimlogic.co.uk
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 4, 2010 at 6:21 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Feb 04, 2010 at 04:52:26PM +0200, Grazvydas Ignotas wrote:
>> On Thu, Feb 4, 2010 at 4:24 PM, Mark Brown
>
> The bodge I'm thinking of would do something like log an error and
> substitute in a dummy regulator when regulator_get() would have faile=
d
> so that the driver sees behaviour equivalent to the stubbed regulator
> API if the bodge is active. =A0A central thing seems much more sensib=
le
> here - there's nothing specific to this driver going on here and havi=
ng
> the API behave in a consistent manner seems good.

I agree that such approach have more sense than checking for -ENODEV
in each and every driver that uses the regulator framework. I just
wonder, if there should be some mechanism that  can switch the
substitution of the dummy regulators on and off. And if yes, how
should the platform code communicate with the regulator core the need
for such dummy regulators...

> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
	Sincerely Yours,
		Mike.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
