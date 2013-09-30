From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2 0/9] omap hwspinlock dt support
Date: Mon, 30 Sep 2013 10:56:51 -0500
Message-ID: <52499F43.3010007@ti.com>
References: <cover.1379445653.git.s-anna@ti.com> <5245A8CA.4020805@ti.com> <alpine.DEB.2.02.1309300309530.17980@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.02.1309300309530.17980-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 09/29/2013 10:12 PM, Paul Walmsley wrote:
> Hi
> 
> On Fri, 27 Sep 2013, Suman Anna wrote:
> 
>> Paul,
>> The hwmod data patches needs to be merged only after the respective DT
>> node patches are merged, without which the hwmod entry will not have a
>> base address while enabling and idling (using sysc) the hwmod during
>> hwmod initialization.
> 
> Hmm, ideally there shouldn't be a merge dependency here. Could you please 
> send a patch to the hwmod core that logs a warning and skips the operation 
> in these circumstances?  Or maybe just skips the registration of the 
> device?
> 

Yes, will look into this. This is not specific to hwspinlock, but may be
seen with others as well if the omap_hwmod_addr_space or its equivalent
is not populated.

regards
Suman

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
