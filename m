From: Arnold <abo_gwapo@yahoo.com>
Subject: RE: Noise causes gpio interrupt
Date: Thu, 25 Jan 2007 23:19:00 -0800 (PST)
Message-ID: <740992.7549.qm@web55304.mail.re4.yahoo.com>
References: <3B6D69C3A9EBCA4BA5DA60D9130274293301B0@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D9130274293301B0@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>, "Syed Mohammed, Khasim" <x0khasim@ti.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

First, Thank you for your help. I really appreciate
it. It seems that my problem is the other way around.
I think I am not getting a noise but instead I could
not detect interrupts that has a fast transition. I
tried to use a switch to see if the driver is working
properly, and it looks fine. It could detect a switch
being press. However when the interupt comes from a
device and the transition of rise to fall is 20ns it
could not detect that an interrupt occured. I also
tried to increase the transition to 20ms and it was
able to detect the interrupt. I am thinking now that
maybe the gpio register have not updated yet the
register but the signal is already falling. So maybe
thats why it didnt see it as an interrupt. Have anyone
encountered the same problem? Is there any recent
patch on the interrupt routine that may solve the
problem?

Thanks erveryone for your help,
Arnold 

--- "Woodruff, Richard" <r-woodruff2@ti.com> wrote:

> Depending on the polarity and the circuit you might
> also get away
> configuring the internal pull-up/down to try and
> help mask any noise.
> 
> In the past for some early designs I recall things
> like the lcd inducing
> noise on the touch screen interrupt.  For that I
> believe we dumped an
> external pull up one the line to stop it (along with
> board routing and
> bits to diminish the noise).  The internal pull's
> aren't so strong, but
> if your on the edge and the driver of that line can
> force the state it
> might be enough to mask it.
> 
> Regards,
> Richard W.
>  
> 
> > -----Original Message-----
> > From:
> linux-omap-open-source-bounces@linux.omap.com 
> >
>
[mailto:linux-omap-open-source-bounces@linux.omap.com]
> On 
> > Behalf Of Syed Mohammed, Khasim
> > Sent: Thursday, January 25, 2007 3:44 AM
> > To: Arnold; linux-omap-open-source@linux.omap.com
> > Subject: RE: Noise causes gpio interrupt 
> > 
> > I don't know about the GPIO module in 5912. If you
> have, you 
> > can try configuring your GPIO interrupt to level
> instead of 
> > edge interrupt. I don't know if debounce time can
> help you in 
> > fixing this.
> >  
> > Regards,
> > Khasim 
> > 
> > ________________________________
> > 
> > From:
> linux-omap-open-source-bounces@linux.omap.com on
> behalf 
> > of Arnold
> > Sent: Thu 1/25/2007 3:40 AM
> > To: linux-omap-open-source@linux.omap.com
> > Subject: Noise causes gpio interrupt 
> > 
> > 
> > 
> > Hi All,
> > 
> > I am working on omap5912 and I am using linux
> 2.6.17.
> > I am using a gpio to handle interrupts. I believe
> that I am 
> > having a noise interrupt which my firmware thinks
> is a really 
> > interrupt. Is there a way to distinguish a noise
> interrupt 
> > from a real interrupt?
> > 
> > 
> > Thanks,
> > Arnold
> > 
> > 
> > 
> >
>
______________________________________________________________
> > ______________________
> > Now that's room service!  Choose from over 150,000
> hotels in 
> > 45,000 destinations on Yahoo! Travel to find your
> fit.
> > http://farechase.yahoo.com/promo-generic-14795097
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> >
>
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> > 
> > 
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> >
>
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> > 
> 



 
____________________________________________________________________________________
Need a quick answer? Get one in minutes from people who know.
Ask your question on www.Answers.yahoo.com
