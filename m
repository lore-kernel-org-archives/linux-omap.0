From: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Subject: Re: [PATCH 3/3] usb: dwc3: add a quirk for device disconnection
 issue in Synopsis dwc3 core
Date: Mon, 12 Jan 2015 18:29:43 +0100
Message-ID: <1421083783.22660.69.camel@x220>
References: <1418695828-605-1-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
	 <1418695828-605-4-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
	 <20141222153730.GA12815@saruman>
	 <CAJ1gpc3jVpz=5ME4+wCJDW5NKihvB4xYzwi0co=UuPtG9Ubmjg@mail.gmail.com>
	 <CAJ1gpc3-Wjtm54WOhO6RXjZft9BMngzyYC0-S-XnTacV-qKgMg@mail.gmail.com>
	 <20141229160641.GD29379@saruman>
	 <CAJ1gpc0Uu4vS2iA_o_W5NaE_QBWDYFZJio7yKvhpaR5f=qWcGA@mail.gmail.com>
	 <20150105170921.GH19336@saruman>
	 <CAJ1gpc3RZnqizhiasrwS8uy1H_wQAi_T0mPcS8LAK4FhmBRJ6A@mail.gmail.com>
	 <20150112172032.GD6525@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150112172032.GD6525@saruman>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: Sneeker Yeh <sneeker.yeh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Thomas Pugliese <thomas.pugliese-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Mosberger <davidm-haPfTeumbwasTnJN9+BGXg@public.gmane.org>, Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Green <andy>
List-Id: linux-omap@vger.kernel.org

On Mon, 2015-01-12 at 11:20 -0600, Felipe Balbi wrote:
> On Sun, Jan 11, 2015 at 11:19:55PM +0800, Sneeker Yeh wrote:
> > in case i express unclearly i also put a pdf:
> > https://drive.google.com/file/d/0B18MmcvvKjNNbDF6eEdHSzZCazA/view
> > 
> > This issue is defined by a two-way race at disconnect, between
> > 1) class driver interrupt endpoint resheduling attempts if the ISR gave an
> > ep error event due to device detach (it would try 3 times)
> > 2) Disconnect interrupt on PORTSC_CSC, which is cleared by hub thread
> > asynchronously
> > 3) The hardware IP was configured in silicon with
> >        - DWC_USB3_SUSPEND_ON_DISCONNECT_EN=1 (this is an IP configuration
> 
> yeah, aparently this is another configuration which is not exposed on
> HWPARAMS registers. Paul, can you confirm for us ? I couldn't find it on
> Databook on any of the HWPARAMS registers.

I guess you meant to ask Pawel, because I know nothing at all about all
that! 

Thanks,


Paul Bolle

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
