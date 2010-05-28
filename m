From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 15:21:25 +0100
Message-ID: <20100528142124.GA26733@srcf.ucam.org>
References: <20100527223605.GB11364@srcf.ucam.org> <20100527235546.09f3ce8a@lxorguk.ukuu.org.uk> <20100528043114.GC26177@thunk.org> <20100528103713.0a7952d9@lxorguk.ukuu.org.uk> <20100528114123.GA22947@srcf.ucam.org> <4BFFB681.1000105@nokia.com> <AANLkTim04ZfMcPHRB2D_bqcAuguaGwySH2b6repuYLkk@mail.gmail.com> <4BFFC5DF.5030504@nokia.com> <20100528133900.GG26177@thunk.org> <4BFFCFC7.7070302@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4BFFCFC7.7070302@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Igor Stoppa <igor.stoppa@nokia.com>
Cc: tytso@mit.edu, ext Brian Swetland <swetland@google.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Fri, May 28, 2010 at 05:14:31PM +0300, Igor Stoppa wrote:

> I have seen very good proposals for saner solutions.
>
> Is that progress?

The proposals so far involve either redefining the problem space or 
being inherently racey. It may be that we can redefine the problem space 
in such a way that everyone's happy, but it's not possible to do so by 
fiat.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
