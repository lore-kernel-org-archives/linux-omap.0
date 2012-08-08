From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 04/11] MFD: twl4030-audio: Add DT support
Date: Wed, 8 Aug 2012 15:39:27 +0100
Message-ID: <20120808143927.GB24328@opensource.wolfsonmicro.com>
References: <1344418887-5262-1-git-send-email-peter.ujfalusi@ti.com>
 <1344418887-5262-5-git-send-email-peter.ujfalusi@ti.com>
 <5022529D.3090406@ti.com>
 <20120808125252.GR16861@opensource.wolfsonmicro.com>
 <50227936.3040701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <50227936.3040701@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dtor@mail.ru>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 08, 2012 at 05:35:34PM +0300, Peter Ujfalusi wrote:

> Does this needs the common clock framework on the platform? OMAP3 certainly
> does not have it enabled since it has not been adopted.

I'd hope at least the binding code for finding clocks has been done at
the clkdev level so it can be used on other platforms but perhaps that's
not the case.
