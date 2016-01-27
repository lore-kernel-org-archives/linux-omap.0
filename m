From: Tony Lindgren <tony@atomide.com>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
Date: Wed, 27 Jan 2016 07:19:22 -0800
Message-ID: <20160127151921.GG19432@atomide.com>
References: <20160126224804.GB19432@atomide.com>
 <CAJZ5v0gTRvyWHVmYNb8Q1QZzhVhokXo541+48mFyDRYv7Hi-Uw@mail.gmail.com>
 <20160126235222.GF19432@atomide.com>
 <2779316.34ov6YOQgv@vostro.rjw.lan>
 <CAPDyKFo-itpp1JUVANSFNiyhKcv1XLUqx1GwRk532LaT+ija0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFo-itpp1JUVANSFNiyhKcv1XLUqx1GwRk532LaT+ija0g@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Ulf Hansson <ulf.hansson@linaro.org> [160127 00:18]:
> On 27 January 2016 at 08:54, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Tuesday, January 26, 2016 03:52:23 PM Tony Lindgren wrote:
> >> Yeah if we do this when !pm_runtime_enabled(dev) it seems it's
> >> safe to pretty much reset everything?
> >
> > Not only safe, but also a good idea apparently. :-)
> 
> I happy to send a patch, extending pm_runtime_reinit() with some more
> data to be reset.
> 
> Or, you or Tony intend to send a patch?

Please do, I'll be glad to test it!

Regards,

Tony
