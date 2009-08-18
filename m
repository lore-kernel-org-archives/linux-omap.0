From: rt_sal retour <youssef.rtsal@gmail.com>
Subject: Probleme to connect OMAP3 DevKit8000 Board card to Pc via rs232
Date: Tue, 18 Aug 2009 08:41:37 +0100
Message-ID: <c717a6ff0908180041h7d6f7f68jc18e641a59f491ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: khasim@ti.com, r-woodruff2@ti.com, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, adrian.hunter@nokia.com
List-Id: linux-omap@vger.kernel.org

Hello,
I have a problem with connecting my PC to the OMAP3 DevKit8000 Board card ;
I can not
communicate with it by terminal (rs232) and I have a screen with
character like this :
=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FB=FF=FF=FF=FF=FF=FF=FF=FF=FB=FF=FF=FF=FF=FB=
=FF=FF=FF=FF=FF=FB=FF=FF=FF=FB=FB=DF=FF=FB=FB=FF=FF=FF=FB=FB=FF=FF=FB=FB=DF=
=FF=FF=FF=DB=FF=FF=FF=FF=FF=FF=FF=FF=FB=FB=FF=FF=FF=FF=FF=FF=FB=FF=FB=FF=DF=
=FF=FF=FF=DF=FF=FB=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=DF=FF=FF=FF=FF=FF=FF=FB=DF=
=FF=FF=FF=FF=FF=FF=FB=FF=FF=FF=FF=FF=FF=FF=FB=FB=FB=FF=DF=FB=FF=DF=FF=FB=FF=
=FF=FF=FF=FB=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FB=FB=FF=FF=FB=FF=FF=
=FB=FF=FF=FF=FF=FF=FB=DB=FF=FF=FF=FF=FF=DF=FF=FF=DF=FF=FB=FF=FF=FF=FF=FF=FB=
=FF=FF=FF=FF=FF=FF=FF=DB=FF=FF=DB=FF=DF=FF=FB=FF=FF=FF=FF=FF=FF=FF=FB=FF=FF=
=FF=FF=FB=FF=FF=FF=FB=FB=FF=FB=FF=FF=FB=FF=FF=FF=FF=FF=DF=FF=FF=FF=DF=FB=FF=
=FB=FF=FF=FF=FB=DF=FF=FB=DF=FF=FB=FF=FF=FF=FF=FB=FF=FF=FF=FF=FB=FB=FF=FF=FB=
=FF=FF=FF=FB=FF=FF=FF=FF=FB=FB=FF=DF=FF=FF=FB=FB=FB=FF=FF=FF=FB=FB=FF=FF=FB=
=FB=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FB=FB=FF=DB=FF=FF=FF=FF=FF=FF=FF=FF=FF=
=DF=FF=FF=FF=FF=FF=FF=FB=FF=FF=DB=FF=FF=FF=FB=FF=DB=DF=FF=FF=FF=FF=FB=FF=FF=
=DF=FB=FF=FF=FB=FF=FB=FF=FB=FF=FB=FF=DB=DF=FF=FF=FF=FF=FF=FB=FF=FF=FF=FB=FB=
=FF=FF=FF=FF=FF=FF=FF=FF=FF=FB=FB=FF=FF=FF=FF=FF=FF=FB=FF=FB=FF=FF=FF=FF=DF=
=FF=FB=FF=DF=FF=FF=FF=FB=FF=FF=FB=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FB=FB=
=FF=DF=FF=FF=FF=FF=FF=FF=FB=FF=FF=FF=FB=FF=FF=FF=FF=FF=FF=FF=FB=FF=FF=FB=FF=
=FF=FF=FF=FF=FF=FF=FF=FB=FF=FB=FF=FB=FF=FF=DF=FF=FF=DB=DF=FF=FF=FB=FF=FF=FF=
=AD=FF=FF=FF=FF=FF=FF=FF=FF=DF=DF=FF=FF=FF=FF=FF=FB=FF=FB=FF=FB=FF=FB=FF=FF=
=FF=FB=FB=FF=FB=FB=FF=DF=FF=FF=FF=FF=FB=FF=FF=FF=FB=DF=FF=FF=FF=FB=FF=FF=FF=
=FF=DF=FB=FB=FF=FF=FF=FF=FF=FB=FB=FF=FF=FF=FB=FF=FF=FB=FF=FF=FF=FF=FF=FF=FB=
=FF=FF=FB=FB=FF=FF=FF=FF=FF=FF=FF=FB=FB=DB=FF=FF=FF=FF=FF=FF=FF=FF=FF=DF=FF=
=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FB=FB=FF=FF=FF=FF=FF=FB=FF=FF=FF=FB=DB=FF=
=FF=FF=FB=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FB=FF=FB=FF=FF=FF=FF=FB=FB=FF=DF=FB=
=FF=DF=FB=FB=FF=FF=FF=FF=FF=FB=EF=FF=FF=FB=DB=FF=FF=FF=FF=FF=FF=FB=FF=FF=FF=
=FF=FF=FF=FF=FF=FF=DF=FB=FF=FF=FF=FF=FF=FF=FF=FF=FB=FF=FF=FF=FF=FF=FF=FF=FF=
=FF=FF=FB=FB=FF=FF=FF=FF=FB=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=
=FF=FF=DF=FF=FB=FF=DF=FF=FF=FF=FB=DF=FB=FB=FB=FF=FB=FB=FF=FF=FF=FB=FF=FF=FF=
=FF=FF=FF=DF=FB=FF=FF=FB=FF=FB=DF=FF=FB=FF=FF=FF=FB=FF=FF=FF=FF=FF=FF=FF=FF=
=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=FF=DF=DF=FF=FF=FF=
=FF=FF=FF=FB=FF=FF=FF=FF=DF=FF=FB=FB=FF=DF...............
i used it under vista.
Regards,
Youssef


-- =

Youssef Fares
Ing=E9nieur  D=E9veloppement

ARDIA
P=F4le Technologique "El-Ghazala"
B=E2t E1

BP 99-2088 - Ariana Nord

TUNISIA

Phone:. +216 96832062

Mob: +216 96832062
E-mail: fares.youssef@ardia.com.tn
Skype:faresardia
http://www.actia.com
-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
