From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 2/4] regulator: adapt fixed regulator driver to dt
Date: Fri, 4 Nov 2011 21:57:33 +0000
Message-ID: <20111104215733.GD8266@opensource.wolfsonmicro.com>
References: <1319702185-16108-1-git-send-email-rnayak@ti.com>
	<1319702185-16108-3-git-send-email-rnayak@ti.com>
	<20111104203422.GB3918@quad.lixom.net>
	<20111104210151.GA2541@opensource.wolfsonmicro.com>
	<20111104211824.GA5608@quad.lixom.net>
	<20111104212538.GA8266@opensource.wolfsonmicro.com>
	<CAOesGMh2_C+yx=_5PjqoKxZmAMvx-puRjq45s+G2kz2EaEEtqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAOesGMh2_C+yx=_5PjqoKxZmAMvx-puRjq45s+G2kz2EaEEtqw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Olof Johansson <olof@lixom.net>
Cc: patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, Rajendra Nayak <rnayak@ti.com>, linux-kernel@vger.kernel.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 04, 2011 at 02:47:05PM -0700, Olof Johansson wrote:
> On Fri, Nov 4, 2011 at 2:25 PM, Mark Brown

> > I don't see how you can usefully do that, the task of plumbing a
> > regulator into a board is largely orthogonal to the specific feature set
> > of a given regulator. =A0The specific bindings for a fixed voltage
> > regulator would be useful or unhelpful for most regultors controlled via
> > I2C.

> I meant more that the fixed regulators should reuse as much as
> possible from the generic regulator bindings, instead of completely
> forking them.

That appears to be what's going on?  The fixed voltage regulator
includes by reference the core regulator binding, all of the properties
it defines with the possible exception of the supply name are not
covered in the core binding.

> Then, depending on how they are controlled, there will be more
> specific bindings. So the case of a gpio-controlled fixed regulator
> would have a binding where the format of the properties to find the
> gpio, etc, would be described. But things like voltage (without a
> range, obviously) would be using the same bindings as the other
> regulators.

The only overlap I'm seeing is the voltage?  =


The intended semantic for the voltage is rather different.  The core
binding for the voltage specifies the range of voltages it is possible
to set a regulator to on a given board and is used to give permission to
the system to reconfigure the regulator.  The binding here tells the
system what voltage a fixed voltage regulator is running at.  We could
have the fixed voltage regulator read the same binding - though there's
some risk of mild confusion it shouldn't be too bad.
