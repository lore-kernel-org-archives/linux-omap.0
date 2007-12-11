From: "Meng Hu" <meng.hu@gmail.com>
Subject: McSPI interfaces in newer kernel
Date: Tue, 11 Dec 2007 13:15:21 -0600
Message-ID: <94d6903b0712111115h297769e2q1709777dd0e65bb7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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

Hi

I am trying to jump from a 2.6.10 montavista kernel to a 2.6.21 one
for OMAP2430.
There are some patches from MonvaVista(originally provided by TI) for
the 2.6.10 kernel which provides some McSPI  implementations, e.g.
drivers/ssi/omap-mcspi.c

I found that these files are not in my 2.6.21 kernel and neither in
the upstream omap linux tree.
Is this because the upstream kernel only contains a small set of omap
drivers OR these old mscpi drivers are replaced by sth. else?
Should I port these files by myself? or change my other drivers to use
the new interfaces. (I am porting a touchscreen driver which heavily
relies on the old mscpi drivers)

Any information would be appreciated!

- Meng
