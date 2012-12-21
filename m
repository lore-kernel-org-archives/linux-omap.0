From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 5/9] mailbox: change protection mechanisms
Date: Fri, 21 Dec 2012 10:28:48 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EC9CE80@DBDE01.ent.ti.com>
References: <1355836212-17956-1-git-send-email-loic.pallardy-ext@stericsson.com>
 <1355836212-17956-6-git-send-email-loic.pallardy-ext@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1355836212-17956-6-git-send-email-loic.pallardy-ext@stericsson.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Loic Pallardy <loic.pallardy-ext@stericsson.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, "Anna, Suman" <s-anna@ti.com>, Russell King <linux@arm.linux.org.uk>, Loic PALLARDY <loic.pallardy@st.com>, Arnd Bergmann <arnd@arndb.de>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Gutierrez,
 Juan" <jgutierrez@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Felipe Contreras <felipe.contreras@nokia.com>, Omar Ramirez Luna <omar.ramirez@copitl.com>, Wim Van Sebroeck <wim@iguana.be>, Dom Cobley <popcornmix@gmail.com>, Tejun Heo <tj@kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 18, 2012 at 18:40:08, Loic Pallardy wrote:
> TX: replace spin by mutex
> RX: replace spin_lock_irq by spin_lock_irqsave
> 

Can you please add a short note on why this is being done?

Regards,
Vaibhav 
