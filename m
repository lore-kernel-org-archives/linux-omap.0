From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc8 regulator-next] regulator: init fixes (v4)
Date: Wed, 18 Mar 2009 12:25:11 -0700
Message-ID: <200903181225.11444.david-b@pacbell.net>
References: <200903111743.34708.david-b@pacbell.net> <200903171115.06685.david-b@pacbell.net> <20090317200828.GA7060@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760594AbZCRTZ5@vger.kernel.org>
In-Reply-To: <20090317200828.GA7060@sirena.org.uk>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tuesday 17 March 2009, Mark Brown wrote:
> On Tue, Mar 17, 2009 at 11:15:06AM -0700, David Brownell wrote:
> > On Monday 16 March 2009, Mark Brown wrote:
> 
> > > Devices that need to do things like set voltages are fairly likely to
> > > own the regulator but with devices that just need to ensure that they
> > > have their supplies enabled it's much more likely that the supplies will
> > > be shared.
> 
> > Right.  Do you have a model how such shared supplies would
> > coexist with the "enabled at boot time" model, and still
> > support being disabled?
> 
> The drivers can essentially ignore the physical status of the regulator
> when they start,

That is, shared supplies should adopt a different model?

That approach can't be used with drivers, as for MMC slots,
which need to ensure they start with a "power off" state as
part of a clean reset/init sequence.

Maybe "sharable" should be a regulator constraint flag, so
the regulator framework can avoid committing nastiness like
allocating multiple consumer handles for them.


> It will also work well with a 
> late_initcall which disables any unreferenced regulators -

The $SUBJECT patch will prevent such things from existing.

Also, regulator use that kicks in before that particular
late_initcall will still see self-inconsistent state in
the regulator framework ... of course, $SUBJECT patch (and
its predecessors) is all about preventing self-inconsistency.

That self-inconsistency doesn't seem to concern you much.
