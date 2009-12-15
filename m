From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3 v3] musb: Add context save and restore support
Date: Tue, 15 Dec 2009 14:10:32 +0200
Message-ID: <20091215121032.GH3689@nokia.com>
References: <1260797982-28880-1-git-send-email-ajay.gupta@ti.com>
 <1260797982-28880-2-git-send-email-ajay.gupta@ti.com>
 <20091214163324.GB31829@nokia.com>
 <19F8576C6E063C45BE387C64729E739404372AAF0F@dbde02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030ADD53A6@dbde02.ent.ti.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030ADD53A6-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "ext Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Dec 15, 2009 at 01:04:01PM +0100, ext Gadiyar, Anand wrote:
>> > I think we should only allow suspend if cable isn't connected. What
>> > would happend if you have mounted fs (using mass storage), user is
>> > transferring files and you force a disconnect ?
>>
>> We force a disconnect during suspend which is actually triggered by user
>> Only. So do we need to consider this scenario?
>>
>
>Like Ajay says, the kernel would need to take a call either way:
>
>- Disallowing a system wide suspend, just because a USB cable is connected
>- Allow a system-wide suspend, but disconnect the gadget device.
>
>
>I would vote to allow a system-wide suspend. A user that tries to put
>a phone to standby in the middle of a data transfer shouldn't be too
>surprised that the data transfer was aborted.

yes, but the problem would be the data corrupted. I'm pretty sure user 
will be a bit surprised that he now can't use his 27GB and lost all 
contacts, movies, smses, etc.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
