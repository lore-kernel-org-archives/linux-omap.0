From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 2/2] DSPBRIDGE: DSP recovery feature
Date: Tue, 23 Mar 2010 14:29:14 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602CACBDF08@dlee06.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E602CA9E405F@dlee06.ent.ti.com>
	 <94a0d4531003190451h23ad1a16x994973cdfeb3c83f@mail.gmail.com>
	 <94a0d4531003190853y7b6bda0dg6db8ab263bbb8532@mail.gmail.com>
	 <19F8576C6E063C45BE387C64729E7394044DE0E3DE@dbde02.ent.ti.com>
	 <94a0d4531003190918v7e943d5ax16baf6945472530c@mail.gmail.com>
	 <94a0d4531003191200r425652c3ybf505c353b2ad847@mail.gmail.com>
	 <496565EC904933469F292DDA3F1663E602CACBD655@dlee06.ent.ti.com>
 <94a0d4531003191511q6135a424r9ce68c632cc826dd@mail.gmail.com>
 <496565EC904933469F292DDA3F1663E602CACBD669@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_496565EC904933469F292DDA3F1663E602CACBDF08dlee06enttico_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53793 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752122Ab0CWT3V (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Mar 2010 15:29:21 -0400
In-Reply-To: <496565EC904933469F292DDA3F1663E602CACBD669@dlee06.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>
Cc: "Hebbar, Shivananda" <x0hebbar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

--_002_496565EC904933469F292DDA3F1663E602CACBDF08dlee06enttico_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



I have tested just using an application (base on bridged code) which is reg=
istered for fatal events and once it receives an event it prints the receiv=
ed event:

status =3D DSPManager_WaitForEvents(notifier, EVENTS, &index,
								DSP_FOREVER);
printf("Event received %s\n", evt_name[index]);  <<< print event received
try_err_out("Catch notification signal", status);


And this is what I get:

#####Load baseimage with absolute path, so that kernel thread can load ####=
#baseimage

# ./cexec.out /dspbridge_reco/ddspbase_tiomap3430.dof64P


#####Run listener.out

# ./listener.out
# DspManager_Open succeeded
DSPProcessor_Attach succeeded
DSP node register notify DSP_MMUFAULT succeeded
DSP node register notify DSP_SYSERROR succeeded
DSP node register notify DSP_PWRERROR succeeded
DSP node register notify DSP_StateChange succeeded
#


#####Cause MMUFault.

# ./faultapp.out ddspbase_tiomap3430.dof64P test
DSP device detected !!
DSPProcessor_Attach succeeded.
DSPNode_Allocate succeeded.
DSPNode_Create succeeded.
DSPNod***** DSPMMU FAULT ***** IRQStatus 0x2  <<< MMUFault caused
e_Run succeeded.
DSPProcessor_R***** DSPMMU FAULT ***** fault_addr 0x80000000
eserveMemory succeeded. dspAddrSbridge_deh_notify: ********** DEVICE EXCEPT=
ION *
*********
end=3D 0x203f0000
DSPProcessor_Rbridge_deh_notify: DSP_MMUFAULT,err_info =3D 0x0
eserveMemory succeeded. dspAddrdbridge_deh_notify: DSP_MMUFAULT, High Addre=
ss =3D
0x8000
Recv=3D 0x2040a000
DSPProcessor_bridge_deh_notify: DSP_MMUFAULT, Low Address =3D 0x0
Map succeeded.
DSPProcessor_Mapbridge_deh_notify: DSP_MMUFAULT, fault address =3D 0x800000=
00
 succeeded.
Sending DMM BUFs toprint_dsp_trace_buffer:
DSP MMU FAULT currtask:0x20061114

 DSP cmd=3DSETUP, DspRecvBuf=3D0x2b2DSPTrace: DSP MMU FAULT currtask:0x2006=
1114

f0, DspSendBuf=3D0x122e8
Read 102400 bytes from input file.
Event received MMU_FAULT   <<< MMUFault detected by the application (notifi=
cation was really received) >>>
Catch notification signal succeeded

^C   <<< kill faultapp.out it is stuck by doing Ctrl + C
# proc_load: Processor Loaded /dspbridge_reco/ddspbase_tiomap3430.dof64P
			<<< baseimage was reloaded successfully >>>
proc_start: dsp in running state
DspManager_Open succeeded
DSPProcessor_Attach succeeded
DSP node register notify DSP_MMUFAULT succeeded
DSP node register notify DSP_SYSERROR succeeded
DSP node register notify DSP_PWRERROR succeeded
DSP node register notify DSP_StateChange succeeded

#


#####Run dmmcopy.out sample to make sure DSP was recovered successfully

# ./dmmcopy.out  ddspbase_tiomap3430.dof64P test
DSP device detected !!
DSPProcessor_Attach succeeded.
DSPNode_Allocate succeeded.
DSPNode_Create succeeded.
DSPNode_Run succeeded.
DSPProcessor_ReserveMemory succeeded. dspAddrSend=3D 0x203f0000
DSPProcessor_ReserveMemory succeeded. dspAddrdRecv=3D 0x2040a000
DSPProcessor_Map succeeded.
DSPProcessor_Map succeeded.
Sending DMM BUFs to DSP cmd=3DSETUP, DspRecvBuf=3D0x203f02e8, DspSendBuf=3D=
0x2040a2f0
Read 102400 bytes from input file.
Writing 102400 bytes to output file.
Read 33684 bytes from input file.
Writing 33684 bytes to output file.
DSPProcessor_UnMap succeeded.
DSPProcessor_UnMap succeeded.
DSPProcessor_UnReserveMemory succeeded.
DSPProcessor_UnReserveMemory succeeded.
RunTask succeeded.

DSPNode_Terminate succeeded.procwrap_detach: deprecated dspbridge ioctl

DSPNode_Delete succeeded.
DSPProcessor_Detach succeeded.
#


You can use the application attached to see if you are able to receive noti=
fications, if you still don't receives the notifications can you share the =
code you are using?


Regards,
Fernando.


>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of Guzman Lugo, Fernando
>Sent: Friday, March 19, 2010 4:31 PM
>To: Felipe Contreras
>Cc: Hebbar, Shivananda; linux-omap@vger.kernel.org; Hiroshi DOYU; Ameya
>Palande; felipe.contreras@nokia.com
>Subject: RE: [PATCH 2/2] DSPBRIDGE: DSP recovery feature
>
>
>
>>-----Original Message-----
>>From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
>>Sent: Friday, March 19, 2010 4:11 PM
>>To: Guzman Lugo, Fernando
>>Cc: Hebbar, Shivananda; linux-omap@vger.kernel.org; Hiroshi DOYU; Ameya
>>Palande; felipe.contreras@nokia.com
>>Subject: Re: [PATCH 2/2] DSPBRIDGE: DSP recovery feature
>>
>>On Fri, Mar 19, 2010 at 11:49 PM, Guzman Lugo, Fernando <x0095840@ti.com>
>>wrote:
>>> Do you mean applying DSP recovery process you are no able to receive
>>MMUFault notifications?
>>>
>>> I am going to check that case. Is there any possibility that the proces=
s
>>is stuck waiting other event?
>>
>>I think mgr_wait_for_bridge_events is constantly failing, so no
>>MMUFAULT notifications come through.
>
>Ok, I am going to see if the patch is changing something related to that
>function and debug the problem.
>
>Regards,
>Fernando.
>
>>
>>--
>>Felipe Contreras
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

--_002_496565EC904933469F292DDA3F1663E602CACBDF08dlee06enttico_
Content-Type: text/plain; name="listener.c"
Content-Description: listener.c
Content-Disposition: attachment; filename="listener.c"; size=3003;
	creation-date="Tue, 23 Mar 2010 14:02:47 GMT";
	modification-date="Tue, 23 Mar 2010 14:02:47 GMT"
Content-Transfer-Encoding: base64

LyoKICogQnJpZGdlIGRyaXZlciBEYWVtb24KICogRFNQIFJlY292ZXJ5IGZlYXR1cmUgZm9yIFRJ
IE9NQVAgcHJvY2Vzc29ycy4KICoKICogQ29weXJpZ2h0IChDKSAyMDA5IFRleGFzIEluc3RydW1l
bnRzLCBJbmMuCiAqCiAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJl
ZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CiAqIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUg
R05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgdmVyc2lvbiAyIGFzCiAqIHB1Ymxpc2hlZCBieSB0
aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLgogKgogKiBUSElTIFBST0dSQU0gSVMgUFJPVklE
RUQgJydBUyBJUycnIEFORCBXSVRIT1VUIEFOWSBFWFBSRVNTIE9SCiAqIElNUExJRUQgV0FSUkFO
VElFUywgSU5DTFVESU5HLCBXSVRIT1VUIExJTUlUQVRJT04sIFRIRSBJTVBMSUVECiAqIFdBUlJB
TlRJRVMgT0YgTUVSQ0hBTlRJQklMSVRZIEFORCBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVS
UE9TRS4KICovCgojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN0cmluZy5oPgoKI2luY2x1
ZGUgPGRiYXBpLmg+CgojZGVmaW5lIHRyeV9lcnJfb3V0KG1zZywgZXJyKQkJCQkJCVwKZG8gewkJ
CQkJCQkJCVwKICAgIGlmIChEU1BfRkFJTEVEKGVycikpIHsJCQkJCQlcCglwcmludGYoIiVzIGZh
aWxlZCA6IEVyciBOdW0gPSAlbHhcbiIsIG1zZywgZXJyKTsJCVwKCWdvdG8gb3V0OwkJCQkJCQlc
CiAgICB9IGVsc2UJCQkJCQkJCVwKCXByaW50ZigiJXMgc3VjY2VlZGVkXG4iLCBtc2cpOwkJCQkJ
XAp9IHdoaWxlICgwKTsKCiNkZWZpbmUgRVZFTlRTIDQKI2RlZmluZSBST09UX0FDQ0VTUwkxNDA2
CgpjaGFyICpldnRfbmFtZVs1XSA9IHsiTU1VX0ZBVUxUIiwgIlNZU19FUlJPUiIsICJQV1JfRVJS
T1IiLAoJCSAiU1RBVEVfQ0hBTkdFIiwgIlVOS05PV04ifTsKCgp1bnNpZ25lZCBsb25nIGJyaWRn
ZV9saXN0ZW5lcih2b2lkKQp7CglEU1BfSFBST0NFU1NPUiBwcm9jOwoJdW5zaWduZWQgaW50IGlu
ZGV4ID0gMCwgaTsKCXVuc2lnbmVkIGxvbmcgc3RhdHVzID0gRFNQX1NPSzsKCXN0cnVjdCBEU1Bf
Tk9USUZJQ0FUSU9OICpub3RpZmllcltFVkVOVFNdOwoKCWZvciAoaSA9IDA7IGkgPCBFVkVOVFM7
IGkrKykgewoJCW5vdGlmaWVyW2ldID0gbWFsbG9jKHNpemVvZihzdHJ1Y3QgRFNQX05PVElGSUNB
VElPTikpOwoJCWlmICghbm90aWZpZXJbaV0pCgkJCXJldHVybiBEU1BfRU1FTU9SWTsKCQltZW1z
ZXQobm90aWZpZXJbaV0sIDAsIHNpemVvZihzdHJ1Y3QgRFNQX05PVElGSUNBVElPTikpOwoJfQoK
CS8qIEJpZyBsaXN0ZW5lciBsb29wICovCgl3aGlsZSAoMSkgewoJCXN0YXR1cyA9IERzcE1hbmFn
ZXJfT3BlbihST09UX0FDQ0VTUywgTlVMTCk7CgkJdHJ5X2Vycl9vdXQoIkRzcE1hbmFnZXJfT3Bl
biIsIHN0YXR1cyk7CgkJc3RhdHVzID0gRFNQUHJvY2Vzc29yX0F0dGFjaCgwLCBOVUxMLCAmcHJv
Yyk7CgkJdHJ5X2Vycl9vdXQoIkRTUFByb2Nlc3Nvcl9BdHRhY2giLCBzdGF0dXMpOwoKCQkvKiBS
ZWdpc3RlciBub3RpZnkgb2JqZWN0cyAqLwoJCXN0YXR1cyA9IERTUFByb2Nlc3Nvcl9SZWdpc3Rl
ck5vdGlmeShwcm9jLCBEU1BfTU1VRkFVTFQsCgkJCQkJRFNQX1NJR05BTEVWRU5ULCBub3RpZmll
clswXSk7CgkJdHJ5X2Vycl9vdXQoIkRTUCBub2RlIHJlZ2lzdGVyIG5vdGlmeSBEU1BfTU1VRkFV
TFQiLCBzdGF0dXMpOwoKCQlzdGF0dXMgPSBEU1BQcm9jZXNzb3JfUmVnaXN0ZXJOb3RpZnkocHJv
YywgRFNQX1NZU0VSUk9SLAoJCQkJCURTUF9TSUdOQUxFVkVOVCwgbm90aWZpZXJbMV0pOwoJCXRy
eV9lcnJfb3V0KCJEU1Agbm9kZSByZWdpc3RlciBub3RpZnkgRFNQX1NZU0VSUk9SIiwgc3RhdHVz
KTsKCgkJc3RhdHVzID0gRFNQUHJvY2Vzc29yX1JlZ2lzdGVyTm90aWZ5KHByb2MsIERTUF9QV1JF
UlJPUiwKCQkJCQlEU1BfU0lHTkFMRVZFTlQsIG5vdGlmaWVyWzJdKTsKCQl0cnlfZXJyX291dCgi
RFNQIG5vZGUgcmVnaXN0ZXIgbm90aWZ5IERTUF9QV1JFUlJPUiIsIHN0YXR1cyk7CgoJCXN0YXR1
cyA9IERTUFByb2Nlc3Nvcl9SZWdpc3Rlck5vdGlmeShwcm9jLAoJCQlEU1BfUFJPQ0VTU09SU1RB
VEVDSEFOR0UsIERTUF9TSUdOQUxFVkVOVCwgbm90aWZpZXJbM10pOwoJCXRyeV9lcnJfb3V0KCJE
U1Agbm9kZSByZWdpc3RlciBub3RpZnkgRFNQX1N0YXRlQ2hhbmdlIiwgc3RhdHVzKTsKCgkJc3Rh
dHVzID0gRFNQTWFuYWdlcl9XYWl0Rm9yRXZlbnRzKG5vdGlmaWVyLCBFVkVOVFMsICZpbmRleCwK
CQkJCQkJCQlEU1BfRk9SRVZFUik7CgkJcHJpbnRmKCJFdmVudCByZWNlaXZlZCAlc1xuIiwgZXZ0
X25hbWVbaW5kZXhdKTsKCQl0cnlfZXJyX291dCgiQ2F0Y2ggbm90aWZpY2F0aW9uIHNpZ25hbCIs
IHN0YXR1cyk7CgkJc3RhdHVzID0gRHNwTWFuYWdlcl9DbG9zZSgwLCBOVUxMKTsKCX0KCm91dDoK
CXN0YXR1cyA9IERTUFByb2Nlc3Nvcl9EZXRhY2gocHJvYyk7CglzdGF0dXMgPSBEc3BNYW5hZ2Vy
X0Nsb3NlKDAsIE5VTEwpOwoKCWZvciAoaSA9IDA7IGkgPCBFVkVOVFM7IGkrKykKCQlmcmVlKG5v
dGlmaWVyW2ldKTsKCglyZXR1cm4gc3RhdHVzOwp9CgoKaW50IG1haW4gKCkKewoJcGlkX3QgY2hp
bGRfcGlkLCBjaGlsZF9zaWQ7CgoJLyogRm9yayBvZmYgdGhlIHBhcmVudCBwcm9jZXNzICovCglj
aGlsZF9waWQgPSBmb3JrKCk7CglpZiAoY2hpbGRfcGlkIDwgMCkgewoJCWV4aXQoMSk7IAkvKiBG
YWlsdXJlICovCgl9CgkvKiBJZiB3ZSBnb3QgYSBnb29kIFBJRCwgdGhlbiB3ZSBjYW4gZXhpdCB0
aGUgcGFyZW50IHByb2Nlc3MuICovCglpZiAoY2hpbGRfcGlkID4gMCkgewoJCWV4aXQoMCk7CS8q
IFN1Y2NlZXNzICovCgl9CgkvKiBDcmVhdGUgYSBuZXcgU0lEIGZvciB0aGUgY2hpbGQgcHJvY2Vz
cyAqLwoJY2hpbGRfc2lkID0gc2V0c2lkKCk7CglpZiAoY2hpbGRfc2lkIDwgMCkKCQlleGl0KDAp
OwoKCWJyaWRnZV9saXN0ZW5lcigpOwoKCXJldHVybiAwOwp9CgoK

--_002_496565EC904933469F292DDA3F1663E602CACBDF08dlee06enttico_--
