From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: DSP setup
Date: Thu, 15 Dec 2005 11:12:10 -0600
Message-ID: <C51F43ABFC95844490F0529B60753BF402DBE392@dlee02.ent.ti.com>
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
To: Louis Jung <lhsj81@gmail.com>, Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Louis,
=20
=20
> Hi, guys, I have made few postings previously in regards to=20
> the DSP setup procedures.
> But I was hoping if anyone could provide a way of gettting=20
> around few of the problems listed below.
>=20
> 1) DSP/BIOS using CCS + DSP tools provided by TI
>     This procedure seems to be very useful, however at the=20
> configuration stage, I need to select the
>     linux type that I am using. There seems to be only three=20
> options , montavista, monterey, nucleus.
>     I am currently using Linux-2.6.12-rc2 with appropriate=20
> patches which does not seem to belong to any
>     of the options listed above. Does anyone know how to=20
> overcome this issue?


I maybe able to help with this. With dsp/bios link v1.12.01 there is a
"make\Linux" directory that contains the contains the makefiles for
building the ARM portion of dsplink. In this directory you will find a
file called "osdefs.mk". This file establishes which distribution of
linux you. In this file you will see that there is a variable called
"GPPDISTRIBUTION". This variable gets set when you run the dsplinkcfg
perl script located in the directory config\bin\. The linux distribution
options that you can choose from are defined in the file dsplinkcfg.opt
also located in config\bin\. If you open dsplinkcfg.opt you should find
the following definition:

@OPT_GPPOS      =3D (
    [
        "",
        "",
        ""
    ],
    [
        "Linux",
        "montavista",
        "Montavista Linux Pro 3.1",
    ],
    [
        "Linux",
        "innovator5910_mvlpro3.0",
        "Montavista Linux Pro 3.0",
    ],
    [
        "Linux",
        "osk5912_mvlpreviewkit3.1",
        "Montavista Linux Pro 3.1 Preview Kit",
    ],
    [
        "Linux",
        "monterey",
        "Monterey Linux",
    ],
    [
        "Nucleus",
        "",
        "Nucleus",
    ]
) ;

If you wish to add another distribution you can simply do something like
the following:

@OPT_GPPOS      =3D (
    [
        "",
        "",
        ""
    ],
    [
        "Linux",
        "myLinux",
        "My Linux",
    ],   =20
    [
        "Linux",
        "montavista",
        "Montavista Linux Pro 3.1",
    ],
    [
        "Linux",
        "innovator5910_mvlpro3.0",
        "Montavista Linux Pro 3.0",
    ],
    [
        "Linux",
        "osk5912_mvlpreviewkit3.1",
        "Montavista Linux Pro 3.1 Preview Kit",
    ],
    [
        "Linux",
        "monterey",
        "Monterey Linux",
    ],
    [
        "Nucleus",
        "",
        "Nucleus",
    ]
) ;

There is one more thing that you need to do. If you had selected the
"Monterey Linux" option when you run the dsplinkcfg perl script and
built dsplink, the osdefs.mk file would have included the file called
"monterey.mk" located in the directory "make\Linux" during the build.
Similarly, if you had selected the "Montavista Linux Pro 3.1 Preview
Kit" option, the osdefs.mk file would have included the file called
"osk5912_mvlpreviewkit3.1.mk" during the build. These *.mk files
included by the osdefs.mk file abstracts the build tools for the linux
distribution from the dsplink make system.=20

Hence, if you now select the "My Linux" option above when you run the
dsplinkcfg perl script and then attempt to build dsplink, the osdefs.mk
file will try to include a file called "myLinux.mk". You need to create
this file and add the definitions that you see defined in the likes of
monterey.mk and osk5912_mvlpreviewkit3.1.mk, for the distribution that
you are using.=20

Regards,
Jon
