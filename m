From: Kiran Bynam <kiran.bynam@flextronicssoftware.com>
Subject: Re: e-linux kernel for P2 board
Date: Wed, 14 Dec 2005 10:22:45 +0530
Message-ID: <OF8126673A.40DFB229-ON652570D7.001A5365-652570D7.001AC6BF@flextronicssoftware.com>
References: <20051213060719.31730.qmail@web32909.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20051213060719.31730.qmail@web32909.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

                                                                           
             Komal Shah                                                    
             <komal_shah802003                                             
             @yahoo.com>                                                To 
                                       Kiran Bynam/HSS@HSS,                
             12/13/2005 11:37          linux-omap-open-source@linux.omap.c 
             AM                        om                                  
                                                                        cc 
                                                                           
                                                                   Subject 
                                       Re: e-linux kernel for P2 board     
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           











--- Kiran Bynam <kiran.bynam@flextronicssoftware.com> wrote:

>
>
>
>
> Hi All,
>
> I am a  new user of the OMAP 730(P2 sample).
>
> we want to port e-linux to the P2 board.
>
> There are two versions of the e-linux available on the TI web site.
>
>  2.4 kernel &  2.6. kernel
>
> open source code is available for 2.6 kernel where as
> link is provided to Monta Vista site for 2.4 kernel.
>
> Can anybody suggest me the difference between these two versions of
> e-linux?
>


I hope you mean e-linux as embedded linux !. I would suggest you to use
2.6.x kernel, where all the latest development happens. Lot's of bugs
were fixed after 2.4.x.

Hi,

Thank you for your reply and suggestion.
Yes, i meant embedded linux for e-linux.
But, I am still confused what is the difference between
Monta Vista Linux and Open source code. What are the extra
features we are going to have in the Monta Vista Linux?

Thanks in advance.

Regards
Kiran.B

You can fetch the latest git tree from
http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=log;t=7

Instruction for OMAP-GIT:
http://www.muru.com/linux/omap

http://lwn.net/Articles/driver-porting/ _or_ LDD3 to see what is new
and make out differences yourself !

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around
http://mail.yahoo.com



***********************  FSS-Unclassified   ***********************
"DISCLAIMER: This message is proprietary to Flextronics Software
Systems Limited (FSS) and is intended solely for the use of the
individual to whom it is addressed. It may contain  privileged or
confidential information and should not be circulated or used for
any purpose other than for what it is intended. If you have received
this message in  error, please notify the originator immediately.
If you are not the intended recipient, you are notified that you are
strictly  prohibited  from  using, copying, altering, or disclosing
the contents of this message.  FSS  accepts no  responsibility  for
loss or damage arising from the use of  the information transmitted
by this email including damage from virus."
