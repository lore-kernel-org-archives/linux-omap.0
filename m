From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] mailbox driver framework for v3.10 merge window
Date: Tue, 9 Apr 2013 12:55:02 +0200
Message-ID: <201304091255.03020.arnd@arndb.de>
References: <37C860A02101E749A747FA2D3C1E3C504A1971@DLEE11.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <37C860A02101E749A747FA2D3C1E3C504A1971@DLEE11.ent.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Anna, Suman" <s-anna@ti.com>
Cc: "Russell King - ARM Linux (linux@arm.linux.org.uk)" <linux@arm.linux.org.uk>, "Loic PALLARDY (loic.pallardy@st.com)" <loic.pallardy@st.com>, "Tony Lindgren (tony@atomide.com)" <tony@atomide.com>, "Linus Walleij (linus.walleij@linaro.org)" <linus.walleij@linaro.org>, "Omar Ramirez Luna (omar.ramirez@copitl.com)" <omar.ramirez@copitl.com>, Olof Johansson <olof@lixom.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thursday 04 April 2013, Anna, Suman wrote:
> OMAP and ST-Ericsson platforms are both using mailbox to communicate with some coprocessors. This series creates a consolidated framework, living under drivers/mailbox.
> The changes mainly contain:
> - create a mailbox framework independent from OMAP h/w
> - creates dbx500 mailbox driver for ST-Ericsson platforms
> - move the omap mailbox out of plat-omap/mach-omapX  adapting to the new framework.
> - minor bug fixes in mailbox code

Pulled into a new next/mailbox branch, to keep it separate from the
existing subsystems.

As a note for you: when you send a pull request, please make sure that you
use a tag that includes the changeset text (your description above), so I
don't have to copy it from the email. I noticed that you do have a tag
"mailbox-for-v3.10" in your tree, but the pull request was for the branch
with the same contents.

	Arnd
