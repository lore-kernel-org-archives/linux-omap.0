From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/7] Implement generic regulator constraints parsing for
 ACPI and OF
Date: Wed, 25 Jan 2017 13:55:21 +0100
Message-ID: <CAJZ5v0hHSadH1KLOGg029VU2qrY900ak0=NnH5HPBKZ=FpB7HQ@mail.gmail.com>
References: <20170125000641.25520-1-furquan@chromium.org> <20170125124911.dxveow7bo3zw5jcc@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170125124911.dxveow7bo3zw5jcc@sirena.org.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Furquan Shaikh <furquan@chromium.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 25, 2017 at 1:49 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jan 24, 2017 at 04:06:34PM -0800, Furquan Shaikh wrote:
>
>> Since regulator properties remain the same across OF and ACPI
>> regulators, this series of patches provides common routine for
>> obtaining regulation constraints from device tree and ACPI nodes. In
>
> As Lorenzo explained this is really not a good idea, ACPI has a power
> management model which is just being ignored here.  If you're producing
> systems using ACPI you really need to use ACPI in a joined up fashion
> rather than just blindly importing all DT bindings into ACPI.  While
> there are many areas where ACPI just doesn't do anything and as a result
> it does make sense to reuse existing DT bindings there are also plenty
> of areas where work has been done on the ACPI side.  Regulators and
> power management are definitely one of those areas.

This is exactly right. :-)

Thanks,
Rafael
