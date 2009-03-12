From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [patch 2.6.29-rc7 regulator-next] regulator: refcount fixes
Date: Thu, 12 Mar 2009 10:56:17 +0000
Message-ID: <1236855377.6781.202.camel@vega.slimlogic.co.uk>
References: <200903111743.34708.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756529AbZCLK4t@vger.kernel.org>
In-Reply-To: <200903111743.34708.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Mark Brown <broonie@sirena.org.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 2009-03-11 at 16:43 -0800, David Brownell wrote:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Fix some refcounting issues in the regulator framework, supporting
> regulator_disable() for regulators that were enabled at boot time
> via machine constraints:
> 
>  - Update those regulators' usecounts after enabling, so they
>    can cleanly be disabled at that level.
> 
>  - Remove the problematic per-consumer usecount, so there's
>    only one level of enable/disable.
> 
> Buggy consumers could notice different bug symptoms.  The main
> example would be refcounting bugs; also, any (out-of-tree) users
> of the experimental regulator_set_optimum_mode() stuff which
> don't call it when they're done using a regulator.
> 
> This is a net minor codeshrink.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---

Applied.

Thanks

Liam
