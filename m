From: "Heilpern, Mark" <mark.heilpern@authentec.com>
Subject: SPI support working?
Date: Tue, 23 Oct 2007 15:16:08 -0400
Message-ID: <5ACCFDF5BCF2C34DB62D54EFA1FDF700479D31@corp-mail01.auth.org>
References: <20071023011920.GL17318@atomide.com><9c9fda240710221845y341a5cb0i50b7e07e6d959853@mail.gmail.com><471E1377.401@googlemail.com>
	<20071023174000.GH5193@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Class: urn:content-classes:message
In-Reply-To: <20071023174000.GH5193@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello,

I'm new to OMAP Linux, and on a project I'm working on I need to use it
to implement SPI. I'm using an OMAP 2430 board that brings SPI2 out to a
header, and the vendor kernel is at version 2.6.19. Applying their
board-specific patch to a 2.6.22 source base (after applying
patch-2.6.22-omap1, of course) resulted in a large number of patch
rejects.

So far I haven't been able to build a kernel with OMAP McSPI support
enabled in it; there have been errors that suggest this stuff has not
recently been compiled... wrong number of arguments to a function
(omap_set_dma_dest_params) and numerous macros undefined anywhere
(OMAP24XX_DMA_SPI[12]_[TR]X[123]).

Is anyone using SPI on an OMAP these days? Am I going to have to manage
my own register driver rather than being able to rely on something
already written? Can I simply rip these definitions from a different
kernel source base and use them (along with fixing the function call
issues, of course)?

Thanks for any replies...


NOTE: The information in this message is intended for the personal and =
confidential use
of the designated recipient(s) named above. To the extent the =
recipient(s) is/are bound
by a non-disclosure agreement, or other agreement that contains an =
obligation of
confidentiality, with AuthenTec, then this message and/or any =
attachments shall be
considered confidential information and subject to the confidentiality =
terms of that
agreement.  If the reader of this message is not the intended recipient =
named above, you
are notified that you have received this document in error, and any =
review, dissemination,
distribution or copying of this message is strictly prohibited. If you =
have received this
document in error, please delete the original message and notify the =
sender immediately.
Thank you.

AuthenTec, Inc.  http://www.authentec.com
