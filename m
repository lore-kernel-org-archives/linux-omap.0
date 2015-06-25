From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RESEND] [PATCH v2 1/2] arm: devtree: Set system_rev from DT
 revision
Date: Thu, 25 Jun 2015 11:03:51 +0100
Message-ID: <20150625100351.GB7576@n2100.arm.linux.org.uk>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
 <3577431.y872Foi4kj@wuerfel> <20150506103752.GG30910@pali>
 <3529567.PeFp1NNa1q@wuerfel> <20150506114417.GI30910@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20150506114417.GI30910@pali>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: devicetree@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@debian.org>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, May 06, 2015 at 01:44:17PM +0200, Pali Roh=E1r wrote:
> On Wednesday 06 May 2015 13:04:01 Arnd Bergmann wrote:
> > What I mean is which code accesses this variable that early?
> > =

> =

> ATAG code is doing it at same early stage, so I added it to same early
> stage...

ATAG code does it early because ATAGs are only available early on, and
it's simpler to parse them all in one go, rather than having to do
multiple passes over the structure - especially when most instances are
just storing an integer to some BSS variable.

-- =

FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
