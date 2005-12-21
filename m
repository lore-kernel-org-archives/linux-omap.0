From: "Jason Huang" <jason.huang@wescongroup.com>
Subject: RE: problem interfacing 8 bit peripheral(OCATAL UART ) with omap
	5910
Date: Wed, 21 Dec 2005 13:59:45 -0800
Message-ID: <002001c60679$daa69ec0$6cfea8c0@wescongroup.com>
References: <20051221174208.43917.qmail@web8321.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20051221174208.43917.qmail@web8321.mail.in.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Sudhir:

You need provide more detailed information (on what you have and what you
observed) for anyone to try to diagnose your problem (or challenge).

>From you stated, I don't see anything wrong in your circuit logic.

What is the OCTAL UART you are using? What code did you use?

Best regards.

Jason Huang
Wescon Technology
408-727-8818 x108 

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of sudhir
kumar
Sent: Wednesday, December 21, 2005 9:42 AM
To: linux-omap-open-source@linux.omap.com
Subject: problem interfacing 8 bit peripheral(OCATAL UART ) with omap 5910

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
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
