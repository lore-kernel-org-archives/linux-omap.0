From: <Ling.Alex@iac.com.tw>
Subject: NAND boot on OMAP2430 SDP GP
Date: Sun, 15 Oct 2006 14:35:18 +0800
Message-ID: <922E8E753B0EE949B450E3AE20BE48435ED11D@IACSMX8.isc.iac>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Dear All,

I=A1=A6m working on an OMAP2430 SDP v1.1 GP device and I have to =
implement booing OMAP2430 from on board NAND flash. According to the =
information I gathered from linux.omap.com, I prepared x-load and sign =
it with CSST tool v1.4, which adds 8-bytes head (image size + Internal =
SRAM load address (0x40204000) info to the raw image. Then I flash it to =
the NAND flash block 0~3 via u-boot=A1=A6s command =A1=A7nand =
write.jffs2=A1=A8.

But it seemed the x-load was not copied to SRAM by the ROM code of =
OMAP2430 when I configured the SDP for NAND booting. Is there anything =
missing for NAND booting for OMAP2430? Any advices will be appreciated.

=20

=20

For NAND booting, I set the DIP switch of SDP as following:

S8

1-ON           2-ON            3-OFF

S9

1-ON           2-ON            3-OFF

=20

=20

=20

Best regards,

Alex

Tel 021-64853668 ext 2434

Mail Ling.Alex@iac.com.tw

=20
