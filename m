From: Carlos Chinea <carlos.chinea@nokia.com>
Subject: Re: [RFC PATCHv2 1/7] HSI: Introducing HSI framework
Date: Tue, 18 May 2010 11:37:33 +0300
Message-ID: <1274171853.7755.22650.camel@localhost>
References: <1273245517-30712-1-git-send-email-carlos.chinea@nokia.com>
	 <1273245517-30712-2-git-send-email-carlos.chinea@nokia.com>
	 <201005141622.12281.s-jan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201005141622.12281.s-jan@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ext Sebastien Jan <s-jan@ti.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 2010-05-14 at 16:22 +0200, ext Sebastien Jan wrote:
> Hi Carlos,
> 
> After review, I do not have many comments on the interface, as we already 
> aligned on most of it.
> 
> Please see my comments inlined below.
> 
> On Friday 07 May 2010 17:18:31 Carlos Chinea wrote:
> [strip]
> > diff --git a/include/linux/hsi/hsi.h b/include/linux/hsi/hsi.h
> [strip]
> > +/**
> > + * hsi_start_tx - Signal the port that the client wants to start a TX
> > + * @cl: Pointer to the HSI client
> > + *
> > + * Return -errno on failure, 0 on success
> > + */
> > +static inline int hsi_start_tx(struct hsi_client *cl)
> > +{
> > +       if (!hsi_port_claimed(cl))
> > +               return -EACCES;
> > +       return hsi_get_port(cl)->start_tx(cl);
> > +}
> > +
> > +/**
> > + * hsi_stop_tx - Signal the port that the client no longer wants to
> >  transmit + * @cl: Pointer to the HSI client
> > + *
> > + * Return -errno on failure, 0 on success
> > + */
> > +static inline int hsi_stop_tx(struct hsi_client *cl)
> > +{
> > +       if (!hsi_port_claimed(cl))
> > +               return -EACCES;
> > +       return hsi_get_port(cl)->stop_tx(cl);
> > +}
> 
> As I can see, these two I/F functions are the way an HSI protocol layer can 
> play with Tx_wake lines if it has to, right? 

Right

> I suppose it allows more flexibility with regards to 3/4 wires HSI flavors 
> management and avoids additional callbacks to Tx_wake related events?

Yep

Br,
Carlos Chinea
