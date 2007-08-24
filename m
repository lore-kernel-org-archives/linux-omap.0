From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: CSST's load to ram feature
Date: Thu, 23 Aug 2007 20:31:02 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742901B8C883@dlee13.ent.ti.com>
References: <a46a26fd0708231825v3f95126fi2a53267ef6f46cb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <a46a26fd0708231825v3f95126fi2a53267ef6f46cb5@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Juha Kuikka <juha.kuikka@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

 > TI's CSST too can, in addition to burning to flash memory,=20
> load binary directly to RAM and execute it from there.
>=20
> This feature works fine with the included example binaries=20
> but I am unable to use it to run x-loader or u-boot.
>=20
> I'm suspecting x-loader/u-boot do not work because they=20
> expect the system to be in a certain state but it is not.
>=20
> Has anybody else had this problem and more importantly found=20
> a solution to it?


I've downloaded x-loader into RAM via lauterbach (or u-boot) and have
gotten it to work.

I did this on the 2420-H4 and 3430-SDP.  I seem to recall fixing some
relocation bugs which were introduced into 2430 which may have stopped
it from working.  If you look at the 3430 xloader I think you can make
it work.  The issue was in the initial assembly in cpu/arm1136.  Now if
it works with CSST is something else.

Regards,
Richard W.
