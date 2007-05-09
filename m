From: Geoffrey Tam <geoffrey@evertz.com>
Subject: Cannot stall an endpoint 0 control transfer from a data stage cal
	lback function
Date: Wed, 9 May 2007 17:56:56 -0400
Message-ID: <0474A5584072DA1197F50007E90E6B1141D460@PORTIA>
Mime-Version: 1.0
Content-Type: text/plain
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
To: "'linux-omap-open-source@linux.omap.com'" <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: Geoffrey Tam 
> Sent: Wednesday, May 09, 2007 5:09 PM
> To: linux-usb-devel@lists.sourceforge.net
> Cc: 'david-b@pacbell.net'
> Subject: RE: [linux-usb-devel] Cannot stall an endpoint 0 control
> transfer from a data stage callback function
> 
> 
> I just took a look at the Linux-OMAP tree 
> (http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;
a=blob;h=aad53fdd2a3041967b2e249c77368c06a663a455>
;hb=bffa508892990cb399a10542b39d4e54387c5549;f=drivers/usb/mus
> b/g_ep0.c), and it doesn't look like my problem will be 
> solved by this code.
> 
> Did I look in the right spot?
> 
> > -----Original Message-----
> > From: David Brownell [mailto:david-b@pacbell.net]
> > Sent: Wednesday, May 09, 2007 4:38 AM
> > To: Geoffrey Tam
> > Cc: linux-usb-devel@lists.sourceforge.net; Greg KH
> > Subject: Re: [linux-usb-devel] Cannot stall an endpoint 0 control
> > transfer from a data stage cal lback function
> > 
> > 
> > On Wednesday 09 May 2007, Greg KH wrote:
> > 
> > > Can you take a look at the file, 
> Documentation/SubmittingPatches and
> > > resend this based on the directions written there for how 
> > to create a
> > > patch in a manner so that we can apply it?
> > > 
> > > Also, if you are having mvista specific issues, I suggest 
> contacting
> > > them, there is nothing we can do about their kernels, and 
> > we do not know
> > > what they add or remove from them, based on the 
> kernel.org releases.
> > 
> > More to the point, that GIT tree for DaVinci doesn't have the
> > latest code for that driver.  Grab it from the Linux-OMAP tree
> > instead ... you'll find various bugs have been fixed since
> > January (or whenever that tree was last updated).
> > 
> > - Dave
> > 
> > 
> 
