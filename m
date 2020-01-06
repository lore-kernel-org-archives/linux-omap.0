From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: dts: am335x-boneblack-common: fix memory size
Date: Mon, 6 Jan 2020 13:05:09 -0800
Message-ID: <20200106210509.GF5885@atomide.com>
References: <20200106130909.7697-1-matwey@sai.msu.ru>
 <CAOCHtYgyN+qXXX1YeEcO+nvRFrAL1HAVVMvjfeJ5nvxVjtFKtg@mail.gmail.com>
 <CAJs94EbUL6o9sM+pwxwpqHVDkFqy7wFRirET-Vq3SNVd3grUsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJs94EbUL6o9sM+pwxwpqHVDkFqy7wFRirET-Vq3SNVd3grUsA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc: Robert Nelson <robertcnelson@gmail.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "open list:OMAP DEVICE TREE SUPPORT" <linux-omap@vger.kernel.org>, "open list:OMAP DEVICE TREE SUPPORT" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Matwey V. Kornilov <matwey@sai.msu.ru> [200106 20:48]:
> пн, 6 янв. 2020 г. в 23:44, Robert Nelson <robertcnelson@gmail.com>:
> >
> > On Mon, Jan 6, 2020 at 7:10 AM Matwey V. Kornilov <matwey@sai.msu.ru> wrote:
> > >
> > > BeagleBone Black series is equipped with 512MB RAM
> > > whereas only 256MB is included from am335x-bone-common.dtsi
> >
> > FYI: While all versions from the factory are 512MB, some 3rd parties
> > offered 1GB reballing upgrades..

So what's the conclusion, is it safe to bump the default size to
512MB then?

The custom ones could use their own dts file if bootloader is not
setting the RAM.

Regards,

Tony
