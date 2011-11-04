From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4 1/4] regulator: helper routine to extract
	regulator_init_data
Date: Fri, 4 Nov 2011 22:35:19 +0000
Message-ID: <20111104223518.GC16978@opensource.wolfsonmicro.com>
References: <1319721864-30067-1-git-send-email-rnayak@ti.com>
	<20111104202905.GA3918@quad.lixom.net>
	<20111104211447.GC2541@opensource.wolfsonmicro.com>
	<20111104212216.GA5756@quad.lixom.net>
	<20111104212910.GB8266@opensource.wolfsonmicro.com>
	<CAOesGMgA7UayF9SJUP0YLnj86GmKBrajsBxv4_kRNNqCsvKTYg@mail.gmail.com>
	<20111104214650.GC8266@opensource.wolfsonmicro.com>
	<CAOesGMjkcExKXhNN1nFGey=wBie0PQGp2XS_r-5Rr3X0p4eNhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAOesGMjkcExKXhNN1nFGey=wBie0PQGp2XS_r-5Rr3X0p4eNhg@mail.gmail.com>
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

On Fri, Nov 04, 2011 at 03:16:12PM -0700, Olof Johansson wrote:
> On Fri, Nov 4, 2011 at 2:46 PM, Mark Brown

> >> Describing that in the device tree using regulator-specifiers
> >> shouldn't be too bad? The LDO will reference the DCDC as the parent
> >> supply (or input or whatever language you prefer). They don't have to
> >> be in the same topology, they will instead be under whatever
> >> controller/bus they are on for control -- i2c, etc.

> > That's not great as it means you've got a separate binding for supplies
> > that happen to be connected to another regulator from that used for
> > other supplies on the device which is particularly confusing in the
> > fairly common case where a regulator chip has multiple supplies. =A0Usi=
ng
> > the same method for binding all supplies seems much neater.

> I'm not following the above 100%, but I think you are saying that you
> would prefer to describe the regulator / power hierarchy in the
> functional topology instead of how the various regulators and supplies
> are organized on i2c busses and other controllers?  And the obvious
> one that would be less than trivial to find a home for would be the
> top-level or freestanding fixed regulators that don't sit on a
> controlling bus.

No, that's not the issue at all.  The issue is that we want a single way
of describing the supplies a device has regardless of their function
(which is what the existing stuff does).

Consider the case of a simple regulator with register control.  It is
going to have a supply used for the regulator itself and almost
certainly also a separate digital buffer supply used to reference the
digital I/O.  It seems bad to specify the first supply in a different
manner to the second, and there are more complex examples where a supply
can be both a regulator input and also a more general purpose supply.
