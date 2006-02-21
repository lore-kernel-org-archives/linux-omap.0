From: "Menon, Nishanth" <x0nishan@ti.com>
Subject: RE: [PATCH] Alsa modularisations and support for tsc2101 2/7
Date: Tue, 21 Feb 2006 08:08:18 -0600
Message-ID: <520AB2AD990DC04082102F77CA1726381036EF@dlee03.ent.ti.com>
References: <9268368b0602200947g57ed39d6y28d4612ed4278cda@mail.gmail.com><520AB2AD990DC04082102F77CA1726381036EB@dlee03.ent.ti.com>
	<9268368b0602210606y5a84b111g459f2b293d4ece4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Daniel Petrini <d.pensator@gmail.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Daniel,
>You mean the codec files moving to sound/ ? With this board file
>approach this cause problems in linking the codec functions in the
>board file. They had to stay in the omap tree not in the sound/ .
>Maybe a better place to them could be plat-omap/ ?
I dont see plat-omap having stuff other than omap specific code - such =
as dma etc.. if we put peripheral chip specific code there, i dont see =
kernel directory's abstraction happening properly sound/.. is the =
perfect place for this. The issue of linking is a minor problem - which =
can be handled by using proper include files.
Regards,
Nishanth Menon
