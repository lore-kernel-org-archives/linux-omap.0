From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: OMAP2430: MUSB: Ethernet Gadget Issue
Date: Wed, 12 Dec 2007 14:55:11 -0600
Message-ID: <5573C19A4BBDB441BED2A44157E9705302C968AE@dlee12.ent.ti.com>
References: <5573C19A4BBDB441BED2A44157E9705302A4C387@dlee12.ent.ti.com>
	<200711231226.44592.david-b@pacbell.net>
	<5573C19A4BBDB441BED2A44157E9705302C29F01@dlee12.ent.ti.com>
	<200712092134.23712.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <200712092134.23712.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> You did say the issue was on the TX side, not the RX side?
> The "obvious problem" here is on the RX side, not TX...


Jeff said that he thought that issue was on the TX side, but I don't
have the knowledge to confirm that from my testing. So if you see
problems from the RX side then this is somewhere else for us to look.=20

Any thoughts on how we should be handling this overrun condition?

Thanks
Jon
