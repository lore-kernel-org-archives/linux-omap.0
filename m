From: Louis Jung <lhsj81@gmail.com>
Subject: DSP setup
Date: Wed, 14 Dec 2005 14:38:38 +1100
Message-ID: <cb6819fd0512131938k474a9688jd55aa3c2f7043602@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi, guys, I have made few postings previously in regards to the DSP setup
procedures.
But I was hoping if anyone could provide a way of gettting around few of th=
e
problems listed below.

1) DSP/BIOS using CCS + DSP tools provided by TI
    This procedure seems to be very useful, however at the configuration
stage, I need to select the
    linux type that I am using. There seems to be only three options ,
montavista, monterey, nucleus.
    I am currently using Linux-2.6.12-rc2 with appropriate patches which
does not seem to belong to any
    of the options listed above. Does anyone know how to overcome this
issue?

2) Linux DSP tools,
    Similar problems to the above. Also, there are many changes that must b=
e
made to .rc files during
    the installation process. This package assumes that you are using
montavista linux, and again I am
    not using montavista...... So I was hoping that someone knows how to ge=
t
around this problem.

3) DSP gateway packages
    I tried downloading dspgw-3.3 and untarred it. However, this package
also relies heavily on the Linux
   DSP tools which leads to the problem that I was mentioning in previous
points....

I would be jumping with joy if someone could give me a hand ( I am very new
to this OMAP DSP programming)
because I just can't set up the DSP to a level where I can start
programming.

Also, is there any other ways of building static DSP tasks other than the
methods mentioned above?

Thank you very much for your time.
Cheers
Louis
