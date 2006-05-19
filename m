From: "Menon, Nishanth" <x0nishan@ti.com>
Subject: RE: DSP/BIOS Bridge driver
Date: Fri, 19 May 2006 04:47:18 -0500
Message-ID: <14ACE099F888004586603AEC0A559C2E098AB5@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Vaibhav Goyal <vaibhav.goyal@ittiam.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> It is not able to find:-
> insmod: /lib/modules/2.6.9-omap1: No such file or directory
> insmod: /lib/modules: No such file or directory
> insmod: bridgedriver.ko: no module by that name found
>=20
> Any clue as where to get them?
make modules
make modules_install
with proper path should at least install ur modules to ur kernel lib
directory.
Regards,
Nishanth Menon
