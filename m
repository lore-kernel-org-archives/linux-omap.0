From: <sathish.madhava@wipro.com>
Subject: OMAP2430 NAND Boot
Date: Thu, 5 Apr 2007 09:25:26 +0530
Message-ID: <42E999AD7A0E4647BF159F467EE4FBCB014B1391@BLR-SGM-MSG01.wipro.com>
References: <782515bb0704041855x4ff69d3bp19d386805eaecf16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <782515bb0704041855x4ff69d3bp19d386805eaecf16@mail.gmail.com>
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


Hi All,

I am trying to do a NAND boot on OMAP2430 SDP Board.
I have created X-load.bin and converted it into x-load.raw.
But I donot know how to convert x-load.raw into .ift format.
Can some body help me out to do this.

1. What kind of tool is to be used to convert x-load.raw into
x-load.raw.ift ?
2. Where can I get this tool ?
3. Or is it just editing some data in x-load.raw file or something else
?

I have used u-boot to burn itself back into NAND flash and now trying to
program Xloader with CSST.

Regards
Sathish Kumar
