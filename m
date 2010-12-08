From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 12/11] omap1: Fix gpio mpuio bank to work for
	multi-omap for 7xx/15xx/16xx
Date: Tue, 7 Dec 2010 17:04:35 -0800
Message-ID: <20101208010434.GH17435@atomide.com>
References: <1290689318-10191-1-git-send-email-charu@ti.com>
	<20101201183357.GI17222@atomide.com>
	<87zkso4hu3.fsf@deeprootsystems.com>
	<AANLkTinY8FKbVvXD29KpgGnsnKwQziXws+zKLZWn69Hj@mail.gmail.com>
	<20101204212554.GM17222@atomide.com>
	<20101207232315.GE17435@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20101207232315.GE17435@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: paul@pwsan.com, b-cousson@ti.com, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Kevin Hilman <khilman@deeprootsystems.com>, p-basak2@ti.com, linux-omap@vger.kernel.org, Cory Maccarrone <darkstar6262@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [101207 15:13]:
> 
> Note that this will cause omap-keypad.c driver to not work on 7xx.
> However, the right fix there is to move over to gpio-keys instead as
> suggested by Cory Maccarrone <darkstar6262@gmail.com> and
> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>.

Updated that to say matrix-keypad instead of gpio-keys as pointed
out by Janusz.

Tony 
