From: "Jason Huang" <jason.huang@wescongroup.com>
Subject: RE: problem interfacing 8 bit peripheral(OCTAL UART ) with omap 5910
Date: Fri, 23 Dec 2005 10:25:28 -0800
Message-ID: <01da01c607ee$4055bf10$6cfea8c0@wescongroup.com>
References: <20051223043025.56699.qmail@web8324.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20051223043025.56699.qmail@web8324.mail.in.yahoo.com>
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

Sudhir,

As I said, your connection is correct: D8:D15 of OMAP to D0:D7 of the UART.
Your description of the problem (e.g., 'unable to access all registers') is
too vague.

Best regards.

Jason Huang

-----Original Message-----
From: sudhir kumar [mailto:sudhir_kum2002@yahoo.co.in] 
Sent: Thursday, December 22, 2005 8:30 PM
To: Jason Huang
Subject: RE: problem interfacing 8 bit peripheral(OCTAL UART ) with omap
5910

hi Jason,
           i think  so i did not formulate my question
properly.
 In OMAP 5910 there is no A0 address line so we are
connecting the A1 adress line of the processor to the
A0 address line of the OCTAL UART.The OCTAL UART we
are using is of  EXAR type XR16L788.
following the same thing we are connecting the A8
address line of the procvessor to the A7 address line
of the OCTAL UART.
                        and as far as data lines are
concerened OCTAL UART data lines are connected to the
HIGHER BYTE data bus i.e. D8 to D16.but now the
problem is that we are able to read the register
having ODD address in the OCTAL UART properly but for
the EVEN address register we have to RIGHT Shift the
data which we have read by 8.And that to some time its
not coming right for the even address.
                          So my problem is that that
why are we not able to access the even address
register properly.
        
                     And  how to make the omap 5910
processor(16-bit) to interface peoperly with the OCTAL
UART(8-bit). so that i can access the data properly.
Is the way i have connected my DATA lines and ADDRESS
lines properly?
  
--- Jason Huang <jason.huang@wescongroup.com> wrote:

> Sudhir:
> 
> You need provide more detailed information (on what
> you have and what you
> observed) for anyone to try to diagnose your problem
> (or challenge).
> 
> >From you stated, I don't see anything wrong in your
> circuit logic.
> 
> What is the OCTAL UART you are using? What code did
> you use?
> 
> Best regards.
> 
> Jason Huang
> 
> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
>
[mailto:linux-omap-open-source-bounces@linux.omap.com]
> On Behalf Of sudhir
> kumar
> Sent: Wednesday, December 21, 2005 9:42 AM
> To: linux-omap-open-source@linux.omap.com
> Subject: problem interfacing 8 bit peripheral(OCATAL
> UART ) with omap 5910
> 
> hi,
>     I am interfacing 8 bit peripheral(OCTAL UART)
> with
> omap 5910 but  i am not able to access all the
> registers of octal uart properly and the data which
> i
> am getting is not reliable.
>                     
>                      I will let u know how we have
> interfaced our OMAP 5910 processors address line  to
> OCTAL UART address line. 
> A0 addressline of the processor is grounded so we
> have
> connected the A1 address line of the omap processor
> to
> the A0 address line of the OCTAL uart.following the
> same thing A8 address line of the omap processor is
> connected to the A7 address line of the Octal UART.
>    And regarding the DATA lines i have connected the
> UART 8 bit data lines to OMAP processor higher byte
> DATA  bus.
>                                           So am i
> doing everything fine? Is any body has worked on it
> .Any kind of help or suggesstion will be really
> helpful.
> 
> Thanks in Advance.
> 
> Regards
> Sudhir
>        
> 
> Send instant messages to your online friends
> http://in.messenger.yahoo.com 
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
>
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> 
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
>
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> 


Send instant messages to your online friends http://in.messenger.yahoo.com 
