From: Tony Lindgren <tony@atomide.com>
Subject: Plan for the PBIAS regulator fix?
Date: Wed, 23 Sep 2015 11:07:16 -0700
Message-ID: <20150923180716.GK23801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Mark,

Got any estimate on when you might be sending out the pull request
for the pending regulator fixes for the -rc cycle? Or are you OK
for me to consider commit b9c93646fd5c immutable and use it as
a base for a fixes branch for the related dts change?

Commit b9c93646fd5c ("regulator: pbias: program pbias register
offset in pbias driver") is on -rc1 and would not merge other
regulator fixes upstream even if it got merged with dts changes
before your other regulator fixes.

Regards,

Tony
