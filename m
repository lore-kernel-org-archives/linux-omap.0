From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: OMAP2430 SDP5.0 TV Out problem
Date: Tue, 18 Dec 2007 11:27:27 +0530
Message-ID: <7EAD1AEEA7621C45899FE99123E124A0014BD2E6@dbde01.ent.ti.com>
References: <904DEC693BE1AB429622C6F5ABA7E0B8038CCBAB@is01ex02.ittiam.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <904DEC693BE1AB429622C6F5ABA7E0B8038CCBAB@is01ex02.ittiam.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Jagadeeswaran R." <jagadeeswaran.r@ittiam.com>, linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com =
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of Jagadeeswaran R.
> Sent: Tuesday, December 18, 2007 10:41 AM
> To: linux-omap@vger.kernel.org; linux-omap-open-source@linux.omap.com
> Subject: OMAP2430 SDP5.0 TV Out problem
>=20
> Hi All,
>=20
>=20
>=20
> I am using the kernel (linux-2.6.14-omap2-v4.tgz) that was download =
from
> http://linux.omap.com/pub/.
>=20
> There is some kind noise/flickering noticed with TV out, ie Text
> displayed gets faded towards the right.
>=20
> It looks like flickering due to high gain in TV out.
>=20
> TV display happens through Video pipeline 2 using the V4L2 driver.
>=20
>
>=20
> Did any one face this problem?
>
This is a known issue, the text display flickers on TV-out. But the =
issue could be fixed using the scaling logic in DSS.
=20
> Please provide me the patch if this was solved.
>=20
I don't have a patch, but the procedure of getting this fixed is to=20
 - Enable Scaling block
 - Get BA0 and BA1 point to same location and modify the size register =
to avoid doing a interlaced scan.
 - Modify ACCU0 ACCU1 registers to tune in the performance. I don't have =
the register values handy, will try to get them and send it across.


But with this you will loose down scaling capability. You will not see =
this flickering for a video as such it's only on static text images.

Regards,
Khasim
=20
