From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: PRCM settings
Date: Fri, 14 Sep 2007 12:41:01 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742901E0CDBA@dlee13.ent.ti.com>
References: <c656a4d20709140331p3150b1f4q5e211ed9bc784930@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <c656a4d20709140331p3150b1f4q5e211ed9bc784930@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: arun c <arun.edarath@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> I use 2430 sdp board.
>=20
> My ram grade is 133. Can i use PRCM 5a configuration in
> X-loader sucessfully?? or i must use some ratio with a
> ram grade less than 133(like PRCM #3)??

Yes 5a is fine and will give you maximum DDR performance.

One good point about #5a over #3 is the CPU to memory ration for #5a is =
1-to-2 instead of 1-to-3 like in #3.  Depending on your system it might =
be more important to have a faster DDR as compared to faster processor =
speed.

Though you would not be doing it with the above, it has been my =
experience that DDR usually over clocks pretty well at nominal =
temperatures.  So it is likely #2 (best non-bin'ed speed) would function =
for performance testing.

Regards,
Richard W.
