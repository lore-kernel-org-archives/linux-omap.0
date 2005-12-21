From: sudhir kumar <sudhir_kum2002@yahoo.co.in>
Subject: problem interfacing 8 bit peripheral(OCATAL UART ) with omap 5910
Date: Wed, 21 Dec 2005 17:43:12 +0000 (GMT)
Message-ID: <20051221174312.51808.qmail@web8311.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

hi,
    I am interfacing 8 bit peripheral(OCTAL UART) with
omap 5910 but  i am not able to access all the
registers of octal uart properly and the data which i
am getting is not reliable.
                    
                     I will let u know how we have
interfaced our OMAP 5910 processors address line  to
OCTAL UART address line. 
A0 addressline of the processor is grounded so we have
connected the A1 address line of the omap processor to
the A0 address line of the OCTAL uart.following the
same thing A8 address line of the omap processor is
connected to the A7 address line of the Octal UART.
   And regarding the DATA lines i have connected the
UART 8 bit data lines to OMAP processor higher byte
DATA  bus.
                                          So am i
doing everything fine? Is any body has worked on it
.Any kind of help or suggesstion will be really
helpful.

Thanks in Advance.

Regards
Sudhir
       

Send instant messages to your online friends http://in.messenger.yahoo.com 
