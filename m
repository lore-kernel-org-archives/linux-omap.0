From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: NAND boot on OMAP2430 SDP GP
Date: Sun, 15 Oct 2006 09:38:42 -0500
Message-ID: <453247F2.3000303@gmail.com>
References: <922E8E753B0EE949B450E3AE20BE48435ED11D@IACSMX8.isc.iac>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <922E8E753B0EE949B450E3AE20BE48435ED11D@IACSMX8.isc.iac>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Ling.Alex@iac.com.tw
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Ling.Alex@iac.com.tw stated on 10/15/2006 1:35 AM:

> Then I flash it to the NAND flash block 0~3 via u-boot=A1=A6s command =A1=
=A7nand write.jffs2=A1=A8.
Wrong. Use csst to flash the x-loader to offset 0. u can read the
userguide on how to do that.
