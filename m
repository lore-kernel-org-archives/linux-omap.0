From: "Saint-Etienne, Eric" <e-saint-etienne@ti.com>
Subject: RE: Noise causes gpio interrupt  (Arnold)
Date: Tue, 30 Jan 2007 09:29:38 +0100
Message-ID: <0AB0CB5257FF3C43A27E201CC8AADA8602E4B1AC@dnce02.ent.ti.com>
References: <20070125150119.31A798062C@linux.omap.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070125150119.31A798062C@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


> I am working on omap5912 and I am using linux 2.6.17.
> I am using a gpio to handle interrupts. I believe that
> I am having a noise interrupt which my firmware thinks
> is a really interrupt. Is there a way to distinguish a
> noise interrupt from a real interrupt?

It looks like you have a floating input. On omap2 it's possible to
enable a pull-down on the pad. This is done using System Control Module
(see TRM).
There may be an equivalent on omap5912.

~eric
