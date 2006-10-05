From: "Sideleau, Scott R" <srs@WPI.EDU>
Subject: RE: Help with LCD on OSK
Date: Thu, 5 Oct 2006 05:48:27 -0400
Message-ID: <CC7B089C59ED6841BAE28F1EA69A8543873721@EXCHDB.admin.wpi.edu>
References: <772F5D89C5E0734B8A86D85DFC6A202404BA265B@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <772F5D89C5E0734B8A86D85DFC6A202404BA265B@dlee03.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Ishigami, Tatsuya" <ishigami@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello,

First, thanks for the reply, Ishigami.

> Is its specification (or datasheet) available public, ideally on-line?

Yes, indeed it is.  Check out the data sheet and full specification =
sheet for
the 320x240 display (scroll to table on bottom of page) at the following =
web
site:

http://www.hantronix.com/2_1.html

> Well, you might first want to understand each parameter with
> the display controller datamanual.
> http://focus.ti.com/lit/ug/spru764b/spru764b.pdf
>
> ...
>
> I hope this page might help.
> http://oskfordummies.hp.infoseek.co.jp/howto/lcd.html

Thanks, I'll check out both of those links now.

> Probably you already know, but the OSK LCD board is already
> is available from the 3rd parties.

Indeed, we were aware of the available OSK LCD boards; however, it being =
a
university project with limited funding, one of the existing (rather
expensive) solutions was not an option.

We have engineered the necessary driver circuitry for the Hantronix =
320x240
Chip-on-Glass LCD and have verified it is receiving the necessary =
voltages
when powered by the OSK development board across Expansion Connector C.

At this point, I believe it to be a software issue.

If you, or anyone else, has any further advice or knowledge in dealing =
with
this aspect of the OSK, any assistance would be greatly appreciated.

Thanks, Ishigami, for your help thus far.
______________________________________________
Scott R. Sideleau
ECE '07, Worcester Polytechnic Institute
@ MQP Ireland A'06, University of Limerick
+353 61-307310 / srs@wpi.edu
