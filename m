From: "Kavita Kalra" <kavita.dsp@gmail.com>
Subject: Problem in configuring DSP/BIOS Link
Date: Tue, 21 Feb 2006 12:08:06 +0530
Message-ID: <c474a93a0602202238o2140573eqd3c91fd3e1b5a91a@mail.gmail.com>
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

Hi All

I am working on TI OMAP 5912. I have configured the ARM as per the
documentation available with the kit. To be able to work on DSP side I
need to configure the DSP/BIOS link. However when i try configuring
DSP/BIOS link by setting the DSPLINK environment variables by issuing
the following command on host :
source ~/dsplink/etc/host/scripts/Linux/gppenv.bash
and build it:
./dsplinkcfg

then rather than taking the path home/username it takes it as:
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
             DSP/BIOS(TM) LINK  Configuration Tool
  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

  DSPLINK is currently defined as:

  /root/dsplink


  1.   Continue.

  2.   Quit to change.

  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

  YOUR CHOICE : 2

what should i do so as  to make it take the correct path             =20
                                                     ???

Regards
Kavita
