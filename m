From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: display freezes
Date: Mon, 4 Jun 2007 10:39:14 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742901217B41@dlee13.ent.ti.com>
References: <a5eaedfa0706040801k50a6b198s32af117b2af682b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <a5eaedfa0706040801k50a6b198s32af117b2af682b6@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Veda N <veda74@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

>   I've trying to get camera and lcd working with a omap 2430=20
> sdp 4.0 board
>=20
> I observe  after 10 minutes or so, the lcd goes blank. i see=20
> a blue screen.
>=20
> I need the camera to continuosly output the images without=20
> lcd going blank.
>=20
> can anyone help me?

Hit a key on the keypad.  That is just likely the screen blanker.

Alternatly you can change the timeout or set it to no blank.  There is a
magic ascii sequence you can echo down, an ioctrl you can use, or use
the setterm utility to set it up.

Regards,
Richard W.
