From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 3/5] regulator: helper routine to extract
	regulator_init_data
Date: Thu, 13 Oct 2011 23:12:33 +0100
Message-ID: <20111013221232.GB2866@opensource.wolfsonmicro.com>
References: <1318263578-7407-1-git-send-email-rnayak@ti.com>
	<1318263578-7407-4-git-send-email-rnayak@ti.com>
	<20111010172222.GG3607@opensource.wolfsonmicro.com>
	<4E93DB41.2080900@ti.com>
	<20111013183821.GN18574@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20111013183821.GN18574@ponder.secretlab.ca>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: b-cousson@ti.com, patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, Rajendra Nayak <rnayak@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 13, 2011 at 12:38:21PM -0600, Grant Likely wrote:

> These *sound* like flags that the driver would set based on its own
> capabilities; in which case it is something that would be encoded
> directly into the driver.

They're almost entirely a combination of system specifics and software
capabilities - it's not even reliably one or the other.  For example the
ability to switch regulator modes is going to depend on a combination of
the modes a specific regulator offers, the set of things connected to
the regulator in the current system (not all of which will be software
visible), how good all the connected consumer drivers are at providing
accurate information about what they're going to need from the system in
terms of quality of regulation and current draw and how good the board
design is in making these things reality.

For robustness (for some of these things if you get it wrong we're
talking catastrophic hardware failure) the Linux regulator API is
extremely conservative and won't touch the hardware unless explicitly
told that a specific thing is OK on a given board.
